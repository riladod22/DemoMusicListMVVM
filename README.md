# DemoMusicListMVVM
實作依照關鍵字搜尋並播放音樂的APP並包含以下功能：
    1. 根據使用者輸入的關鍵字進行搜尋 API，Search bar 每輸入一個字都要要顯示搜尋結果。
    2. UI 使用 UICollectionview 顯示搜尋結果。
        1. 每個 Cell上，顯示 "artworkUrl100" 圖片。
        2. Cell 寬高
           1. 寬：螢幕寬度。
           2. 高：如果API返回資料有 "longDescription"，需根據 "longDescription" 的文字長度動態調整。
    3. 播放 "previewUrl" 音訊。
    4. 點擊 Cell 可播放/暫停 音訊
    5. cell 顯示「播放/暫停」 的狀態，讓使用者區別正在播放的音訊。

註：
包含使用cocoapods串接第三方庫
