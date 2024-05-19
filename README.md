## Memento Pattern in Swift

The Memento Pattern encapsulates an object’s state so it can be saved and restored later. This keeps the internal state hidden.

The Memento Pattern has *three main components*:
1. Originator: The object whose state is saved and restored.
2. Memento: The object that stores the state.
3. Caretaker: Manages Memento objects and handles saving and restoring the Originator’s state.

### Overview

We’ll implement a simple drawing app using the Memento Pattern in Swift. The user can draw on a canvas and undo their last action, restoring the canvas to its previous state.


### Implementation

*Originator*

The DrawingCanvas class represents the canvas. It can save and restore its current drawing state.

```
class DrawingCanvas: UIView {
    private var currentDrawing: UIImage?
    
    func createMemento() -> DrawingMemento {
        return DrawingMemento(state: currentDrawing)
    }
    
    func restore(memento: DrawingMemento) {
        self.currentDrawing = memento.getState()
        self.setNeedsDisplay()
    }
}
```

**Memento**

The DrawingMemento class stores the drawing state.
```
class DrawingMemento {
    private let state: UIImage?
    
    init(state: UIImage?) {
        self.state = state
    }
    
    func getState() -> UIImage? {
        return state
    }
}
```
**Caretaker**

The DrawingCaretaker class manages DrawingMemento objects.
```
class DrawingCaretaker {
    private var mementos: [DrawingMemento] = []
    
    func saveMemento(memento: DrawingMemento) {
        mementos.append(memento)
    }
    
    func getMemento() -> DrawingMemento? {
        return mementos.popLast()
    }
}
```

Example Usage

The user can draw on the canvas and undo the last drawing action to restore the previous state.
```
class DrawingViewController: UIViewController {
    private let canvas = DrawingCanvas()
    private let caretaker = DrawingCaretaker()
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        // Handle drawing on canvas
    }
    
    func startNewDrawing(at point: CGPoint) {
        caretaker.saveMemento(memento: canvas.createMemento())
        // Start new drawing
    }
    
    @objc func undoLastAction() {
        if let memento = caretaker.getMemento() {
            canvas.restore(memento: memento)
        }
    }
}
```


https://github.com/brightspread/Memento/assets/59555700/9b03af0a-17e8-4c00-91aa-a7e9fc9550a1



