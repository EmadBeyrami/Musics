//
//  MainViewModel.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation
import RxSwift

final class MainViewModel {
    
    // MARK: - Service init and inject
    var musicService: MusicServiceProtocol
    
    init(musicService: MusicServiceProtocol) {
        self.musicService = musicService
    }
    
    // MARK: - Properties
    public var isFinished = false
    public var isPaging = false
    public var isSearching = false
    
    private var currentPage = 0
    private var maxPage = 5
    
    var musicList: [Session] = []
    var filteredList: [Session] = []
    
    // MARK: Publishers
    var loading: PublishSubject<Bool> = PublishSubject()
    
    var searchLoading: PublishSubject<Bool> = PublishSubject()
    
    var musics: PublishSubject<[Session]> = PublishSubject()
    var errorHandler: PublishSubject<String> = PublishSubject()
    
    // MARK: - API Call
    func getMusicList() {
        loading.onNext(true)
        musicService.getMusicList { [weak self] result in
            guard let self = self else { return }
            self.loading.onNext(false)
            switch result {
            case .success(let result):
                if let musics = result.data?.sessions {
                    self.musicList.append(contentsOf: musics)
                }
                
                self.musics.onNext(self.musicList)
            case .failure(let error):
                self.errorHandler.onNext(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Pagination Handler
    func getNextPageMusics() {
        isPaging = true
        self.currentPage += 1
        if self.currentPage == self.maxPage {
            self.isFinished = true
        } else {
            getMusicList()
        }
    }
    
    // MARK: - Search Handler
    @discardableResult
    func search(for text: String) -> [Session] {
        filteredList = musicList
        
        self.filteredList = musicList.filter({ (music) -> Bool in
            let titleMatch = music.currentTrack?.title?.range(of: text, options: NSString.CompareOptions.caseInsensitive)
            let nameMatch = music.name?.range(of: text, options: NSString.CompareOptions.caseInsensitive)
            let genresMatch = music.searchInGeneres(text: text)
            return titleMatch != nil || genresMatch || nameMatch != nil
        })
        return filteredList
    }
    
    // MARK: - Search state assigner
    func isSearching(_ isTrue: Bool = true) {
        self.isSearching = isTrue
        filteredList = isTrue ? musicList : []
    }
    
    // MARK: - Paginate Logic Validator
    func isValidForPaging(index: IndexPath.Index, dataSourceCount: Int) -> Bool {
        if !filteredList.isEmpty { return  false }
        return index == dataSourceCount && !isFinished && !isSearching && !isPaging
    }
}
