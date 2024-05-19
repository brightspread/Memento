//
//  DrawingCaretaker.swift
//  Memento
//
//  Created by Leo on 5/19/24.
//

import Foundation

class DrawingCaretaker {
    private var mementos: [DrawingMemento] = []
    
    func saveMemento(memento: DrawingMemento) {
        mementos.append(memento)
    }
    
    func getMemento() -> DrawingMemento? {
        return mementos.popLast()
    }
}
