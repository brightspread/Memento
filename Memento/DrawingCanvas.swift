//
//  DrawingCanvas.swift
//  Memento
//
//  Created by Leo on 5/19/24.
//

import UIKit

class DrawingCanvas: UIView {
    private var currentDrawing: UIImage?
    
    func setDrawing(_ image: UIImage) {
        self.currentDrawing = image
        self.setNeedsDisplay()
    }
    
    func getDrawing() -> UIImage? {
        return currentDrawing
    }
    
    func createMemento() -> DrawingMemento {
        return DrawingMemento(state: currentDrawing)
    }
    
    func restore(memento: DrawingMemento) {
        self.currentDrawing = memento.getState()
        self.setNeedsDisplay()
    }
    
    func reset() {
        self.currentDrawing = nil
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .white
        currentDrawing?.draw(in: rect)
    }
}
