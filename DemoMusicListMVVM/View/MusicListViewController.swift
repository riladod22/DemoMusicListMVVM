//
//  MusicListViewController.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import UIKit

class MusicListViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var cvMisicList: UICollectionView!
    
    lazy var model: MusicListViewModel = {
        return MusicListViewModel()
    }()

    var viewData: MusicListViewData {
        return model.viewData
    }
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        dataBinding()
        model.start()
    }
    
    private func viewInit() {
        setupTextField(tfSearch)
        setupMusicList()
    }
    
    private func dataBinding(){
        
        viewData.musicListData.addObserver(sendNow: false){[weak self] isLoading in
            
            self?.cvMisicList.reloadData()
        }
        
        viewData.networkMessage.addObserver(sendNow: false){[weak self] networkMessage in
            if networkMessage.count > 0 {
                DispatchQueue.main.async {
                    self?.showAlertMessage(title: "訊息",
                                           message: networkMessage,
                                           okEvent: nil)
                    self?.viewData.networkMessage.value = ""
                }
            }
        }
    }
    
    //MARK: UI event
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //組合出輸入文字
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        //執行查詢
        self.model.getSearch(newString ?? "")
        
        return true
    }
}

extension MusicListViewController {
    private func setupTextField(_ tf: UITextField){
        tf.layer.cornerRadius = 6.0
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.init(rgb: 0x000000).cgColor
        tf.backgroundColor = UIColor.init(rgb: 0xFFFFFF)
        tf.delegate = self
    }
    
    private func setupMusicList(){
        
        //設定UICollectionView Layout
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //section間距
        layout.minimumLineSpacing = 5 //cell間距
        layout.estimatedItemSize = CGSize(width: SCREEN_WIDTH, height: 96)
        layout.scrollDirection = .vertical //方向
        
        cvMisicList.collectionViewLayout = layout
        cvMisicList.delegate = self
        cvMisicList.dataSource = self
        cvMisicList?.register(UINib(nibName: "MusicListCell", bundle: nil), forCellWithReuseIdentifier: "MusicListCell")
    }
}

extension MusicListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MusicListCellDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewData.musicListData.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicListCell.cellIdentifier(), for: indexPath) as! MusicListCell
        
        cell.setCellData(viewData.musicListData.value[indexPath.row])
        cell.cellIdx = indexPath
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth:CGFloat = SCREEN_WIDTH
        let itemHeight:CGFloat = 96.0
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: cell delegate
    func btnPlayClicked(atIndex cellIdx: IndexPath) {
        //點擊播放鈕
        model.playMusic(model.viewData.musicListData.value[cellIdx.row])
    }
}


