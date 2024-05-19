//
//  DrawingMemento.swift
//  Memento
//
//  Created by Leo on 5/19/24.
//

import UIKit

class DrawingMemento {
    private let state: UIImage?
    
    init(state: UIImage?) {
        self.state = state
    }
    
    func getState() -> UIImage? {
        return state
    }
}
