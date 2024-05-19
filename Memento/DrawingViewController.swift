//
//  DrawingViewController.swift
//  Memento
//
//  Created by Leo on 5/19/24.
//

import UIKit

class DrawingViewController: UIViewController {
    private let canvas = DrawingCanvas()
    private let caretaker = DrawingCaretaker()
    private var currentPath: UIBezierPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 캔버스 설정
        view.backgroundColor = .white
        canvas.frame = view.bounds
        view.addSubview(canvas)
        
        // 버튼 설정
        let undoButton = UIButton(type: .system)
        undoButton.setTitle("Undo", for: .normal)
        undoButton.frame = CGRect(x: 20, y: view.bounds.height - 60, width: 80, height: 40)
        undoButton.addTarget(self, action: #selector(undoLastAction), for: .touchUpInside)
        view.addSubview(undoButton)
        
        // 팬 제스처 설정
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: canvas)
        
        switch gesture.state {
        case .began:
            startNewDrawing(at: touchPoint)
        case .changed:
            continueDrawing(at: touchPoint)
        case .ended:
            finishDrawing()
        default:
            break
        }
    }
    
    func startNewDrawing(at point: CGPoint) {
        // 현재 상태 저장
        if let currentDrawing = canvas.getDrawing() {
            caretaker.saveMemento(memento: canvas.createMemento())
        }
        
        // 새로운 경로 생성
        currentPath = UIBezierPath()
        currentPath?.move(to: point)
    }
    
    func continueDrawing(at point: CGPoint) {
        guard let currentPath = currentPath else { return }
        currentPath.addLine(to: point)
        drawCurrentPath()
    }
    
    func finishDrawing() {
        
        // 현재 경로를 이미지로 변환하여 저장
        UIGraphicsBeginImageContext(canvas.bounds.size)
        canvas.layer.render(in: UIGraphicsGetCurrentContext()!)
        currentPath?.stroke()
        let newDrawing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 새 그림 설정
        if let newDrawing = newDrawing {
            addNewDrawing(newDrawing)
        }
        
        currentPath = nil
    }
    
    func drawCurrentPath() {
        guard let currentPath = currentPath else { return }
        
        UIGraphicsBeginImageContext(canvas.bounds.size)
        canvas.layer.render(in: UIGraphicsGetCurrentContext()!)
        currentPath.stroke()
        let currentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        canvas.setDrawing(currentImage ?? UIImage())
    }
    
    func addNewDrawing(_ image: UIImage) {
        canvas.setDrawing(image)
    }
    
    @objc func undoLastAction() {
        if let memento = caretaker.getMemento() {
            canvas.restore(memento: memento)
        } else {
            canvas.reset()
        }
    }
}
