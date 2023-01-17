//
//  Observerable.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation

class Observerable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }

    private var valueChanged: ((T) -> Void)?

    init(value: T) {
        self.value = value
    }

    func addObserver(sendNow: Bool = true, _ onChange: ((T) -> Void)?) {
        
        valueChanged = onChange
        if sendNow {
            onChange?(value)
        }
    }

    func removeObserver() {
        valueChanged = nil
    }

}
