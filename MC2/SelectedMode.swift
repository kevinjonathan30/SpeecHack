//
//  SelectedMode.swift
//  MC2
//
//  Created by Kevin Jonathan on 14/06/21.
//

import Foundation

struct SelectedMode {
    private var selectedIndex: Int
    
    init() {
        selectedIndex = 0
    }
    
    func getSelectedIndex() -> Int {
        return selectedIndex
    }
    
    mutating func setSelectedIndex(index: Int) {
        self.selectedIndex = index
    }
}

var selectedMode: SelectedMode = SelectedMode()
