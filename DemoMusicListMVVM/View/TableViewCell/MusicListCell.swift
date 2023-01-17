//
//  MusicListCell.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/13.
//

import Foundation
import SDWebImage

protocol MusicListCellDelegate {
    func btnPlayClicked(atIndex cellIdx: IndexPath)
}

class MusicListCellData {
    var isPlaying = Observerable<Bool>(value: false)
    var musicListData = Observerable<SearchResult>(value: SearchResult())
    
    init(withSearchResult searchResult: SearchResult) {
        self.isPlaying.value = false
        self.musicListData.value = searchResult
    }
}

class MusicListCell: UICollectionViewCell {
    
    @IBOutlet weak var ivThumbImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    
    var delegate : MusicListCellDelegate?
    var cellIdx: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivThumbImage.layer.cornerRadius = 6.0
        ivThumbImage.clipsToBounds = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //自適應高度
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let size = self.systemLayoutSizeFitting(layoutAttributes.size)
        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = size.height
        layoutAttributes.frame = cellFrame
        
        return layoutAttributes
    }
    
    //MARK: process event
    func setCellData(_ data: MusicListCellData) {
        
        //設置資料
        ivThumbImage.sd_setImage(with: URL(string: data.musicListData.value.artworkUrl100 ?? ""))
        lblDescription.text = data.musicListData.value.longDescription
        self.ivStatusSetImage(data.isPlaying.value)
        
        //data binding
        data.isPlaying.addObserver(sendNow: false){[weak self] isPlaying in
            self?.ivStatusSetImage(isPlaying)
        }
    }
    
    private func ivStatusSetImage(_ isPlaying: Bool){
        let statusImage = UIImage.init(named: (isPlaying ? "ic_pause" : "ic_play"))
        self.btnPlay.setBackgroundImage(statusImage, for: .normal)
    }
    
    //MARK: UI event
    @IBAction func btnPlayClicked(_ sender: Any) {
        if let cellIdx = cellIdx {
            self.delegate?.btnPlayClicked(atIndex: cellIdx)
        }
    }
}
