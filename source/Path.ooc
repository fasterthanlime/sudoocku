import structs/[Stack]
import Node

Path: class {
    
    stack: Stack<Node>
    
    init: func {
        stack = Stack<Node> new()
    }
    
    pop:  func -> Node   { stack pop()   }
    peek: func -> Node   { stack peek()  }
    push: func (n: Node) { stack push(n) }
    
}

