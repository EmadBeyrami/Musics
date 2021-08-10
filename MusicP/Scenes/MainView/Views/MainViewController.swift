//
//  MainViewController.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseVC, Storyboarded {
    
    // MARK: - Coordinator
    weak var coordinator: AppCoordinator?
    
    // MARK: - ViewModel
    private var mainViewModel = MainViewModel(musicService: MusicService.shared)
    
    // MARK: - Outlets
    // Not using weak IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var collectionViewDataSource: MusicCollectionViewDataSource<HomeMusicCVCell>!
    
    private lazy var searchbar: UISearchController = {
        let search = UISearchController()
        search.searchBar.showsCancelButton = false
        search.searchBar.placeholder = LocalizedStrings.search.value
        search.searchBar.sizeToFit()
        self.definesPresentationContext = true
        return search
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
        makeAPICall()
    }
    
    // MARK: - View
    private func setupView() {
        // Navigation Controller
        setupNavigationView()
        // CollectionView
        collectionViewDataSource = MusicCollectionViewDataSource(items: [], collectionView: collectionView, delegate: self)
        collectionView.delegate = collectionViewDataSource
        collectionView.dataSource = collectionViewDataSource
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        collectionView.contentInset.bottom = 10
    }
    
    private func setupNavigationView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = LocalizedStrings.discover.value
        navigationItem.searchController = searchbar
        navigationItem.hidesSearchBarWhenScrolling = false
        let langImage = UIImage(systemName: "network")
        let languageBarBtn = UIBarButtonItem(image: langImage,
                                             style: .plain,
                                             target: self,
                                             action: #selector(changeLanguage))
        navigationItem.rightBarButtonItem = languageBarBtn
    }
    
    // MARK: - Language manager button
    @objc func changeLanguage() {
        self.present(changeLanguageAlertController, animated: true, completion: nil)
    }
    
    // MARK: - Bindings
    private func setupBinding() {
        
        // MARK: Loading
        mainViewModel.loading
            .observe(on: MainScheduler.instance)
            .bind(to: view.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // MARK: MusicList
        mainViewModel.musics
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] musicList in
                guard let self = self else { return }
                self.collectionViewDataSource.appendItemsToCollectionView(musicList)
                self.mainViewModel.isPaging = false
            }).disposed(by: disposeBag)
        
        // MARK: error handle
        mainViewModel.errorHandler
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                guard let self = self else { return }
                self.showAlert(message: message)
            }).disposed(by: disposeBag)
        
        // MARK: SearchBar editChanged
        searchbar.searchBar.searchTextField.rx
            .controlEvent(.editingChanged)
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                guard let text = searchbar.searchBar.searchTextField.text,
                      !text.isEmpty else {
                    self.collectionViewDataSource.refreshWithNewItems(mainViewModel.musicList)
                    return
                }
                self.collectionViewDataSource.refreshWithNewItems(mainViewModel.search(for: text))
            }).disposed(by: disposeBag)
        
        // MARK: searchbar begin edit
        searchbar.searchBar.searchTextField.rx
            .controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                guard let text = self.searchbar.searchBar.searchTextField.text,
                      !text.isEmpty else {
                    self.mainViewModel.isSearching(false)
                    return
                }
                
                self.mainViewModel.isSearching()
                
            }).disposed(by: disposeBag)
        
        // MARK: searchbar end edit
        searchbar.searchBar.searchTextField.rx
            .controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                guard let text = self.searchbar.searchBar.searchTextField.text,
                      !text.isEmpty else {
                    self.collectionViewDataSource.refreshWithNewItems(self.mainViewModel.musicList)
                    self.mainViewModel.isSearching(false)
                    return
                }
                self.mainViewModel.isSearching = true
            }).disposed(by: disposeBag)
        
        // MARK: Language Handler
        userChangedLanguageHandler
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] language in
                guard let self = self else { return }
                LanguageManager.shared.currentLanguage = language
                self.coordinator?.userChangedLanguage()
            }).disposed(by: disposeBag)
        
    }
    
    // MARK: - API Calls
    private func makeAPICall() {
        mainViewModel.getMusicList()
    }
}

// MARK: - collection view delegate
extension MainViewController: MusicCollectionViewDelegate {
    
    func collection(willDisplay cellIndexPath: IndexPath, cell: UICollectionViewCell) {
        if mainViewModel.isValidForPaging(index: cellIndexPath.item,
                                          dataSourceCount: collectionViewDataSource.items.count - 1) {
            mainViewModel.getNextPageMusics()
        }
    }
    
}
