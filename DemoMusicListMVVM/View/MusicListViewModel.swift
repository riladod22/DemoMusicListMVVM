//
//  MusicListViewModel.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import UIKit
import AVKit

//MARK: data
class MusicListViewData {
    var musicListData = Observerable<[MusicListCellData]>(value: [])
    var networkMessage = Observerable<String>(value: "")
    
    //執行中cell的data
    var currentCellData: MusicListCellData = MusicListCellData.init(withSearchResult: SearchResult())
}

//MARK: view module
class MusicListViewModel {
    let apiService: ApiService = ApiService()
    var viewData: MusicListViewData = MusicListViewData()

    var musicPlayer: AVPlayer?
    
    func start(){
        getSearch()
    }
    
    func getSearch(_ term: String = ""){
        
        ApiService.sharedInstance.getSearch(term: term) { result in
            
            switch result {
            case .success(let responseData):
                //responseData 轉 viewData
                var listData: [MusicListCellData] = []
                
                var i: Int = 0
                for item in responseData.results {
                    listData.append(MusicListCellData.init(withSearchResult: item))
                    i += 1
                }
                
                self.viewData.musicListData.value = listData
                
            case .failure(let error):
                self.viewData.networkMessage.value = error ?? "" //訊息顯示到畫面
                print(error ?? "")
            }
        }
    }
    
    func playMusic(_ cellData: MusicListCellData){
        //選擇music播放or暫停
        
        if viewData.currentCellData === cellData {
            //已選擇
            let isPlaying = viewData.currentCellData.isPlaying.value
            
            viewData.currentCellData.isPlaying.value = !isPlaying
            if let player = musicPlayer {
                if isPlaying {
                    player.pause() //播放中 -> 暫停
                }else{
                    player.play() //暫停中 -> 播放
                }
            }
        }else{
            //未選擇
            viewData.currentCellData.isPlaying.value = false
            cellData.isPlaying.value = true
            
            viewData.currentCellData = cellData
            
            preparePlayerToPlay(usingUrl: URL(string: viewData.currentCellData.musicListData.value.previewUrl ?? ""))
        }
    }
    
    private func preparePlayerToPlay(usingUrl musicUrl: URL?){
        //設定 music player + 播放
        
        guard let musicUrl = musicUrl else { return }
        
        if musicPlayer == nil {
            musicPlayer = AVPlayer.init(url: musicUrl)
            musicPlayer!.actionAtItemEnd = .none
            
            NotificationCenter.default.addObserver(self, selector: #selector(itemDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime  , object: nil)
        }else{
            let newItem = AVPlayerItem.init(url: musicUrl)
            musicPlayer!.replaceCurrentItem(with: newItem)
        }
        
        musicPlayer!.play()
    }
    
    @objc private func itemDidFinishPlaying(){
        //播放完畢
        viewData.currentCellData.isPlaying.value = false
    }
}
