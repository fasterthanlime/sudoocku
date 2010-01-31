import structs/[List, ArrayList]
import Matrix

Node: class {
    
    matrix: Matrix
    children: List<Node>
    
    init: func(=matrix) {}
    
    add: func(n: Node) {
        list() add(n)
    }
    
    list: func -> List<Node> {
        if(!children) children = ArrayList<Node> new()
        children
    }
    
    clone: func -> This { new(matrix clone()) }
    print: func { matrix print() }
    
    makeHoles: func (howMany: Int) {
        for(i in 0..howMany) {
            matrix[rand() % 9, rand() % 9] = -1
        }
    }
    
    holes: func -> Int {
        
        holes := 0
        for(y in 0..9) for(x in 0..9) {
            if(matrix[x, y] == -1) holes += 1
        }
        holes
        
    }
    
    score: func -> Int {
        
        score := 0
        
        {
            row : Bool[9]
            for(y in 0..9) {
                for(i in 0..9) row[i] = false
                
                for(x in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        continue
                    }
                    if(row[v - 1] == true) {
                        score = score - 1
                    }
                    row[v - 1] = true
                }
            }
        }
        
        {
            col : Bool[9]
            for(x in 0..9) {
                for(i in 0..9) col[i] = false
                
                for(y in 0..9) {
                    v := matrix[x, y]
                    if(v == -1) {
                        continue
                    }
                    if(col[v - 1] == true) {
                        score = score - 1
                    }
                    col[v - 1] = true
                }
            }
        }
        
        score
        
    }
    
    /**
     * @return true if a randomization was possible, false if not
     */
    randomize: func -> Bool {
        
        isLegal := false
        
        while(!isLegal) {
            isPossible := false
            for(y in 0..9) {
                for(x in 0..9) {
                    if(matrix[x, y] == -1) {
                        isPossible = true
                        break
                    }
                }
                if(isPossible) break
            }
            
            if(!isPossible) return false
            
            x, y: Int
            
            while(true) {
                x = (rand() % 9)
                y = (rand() % 9)
                
                v := matrix[x, y]
                if(v == -1) {
                    matrix[x, y] = (rand() % 9) + 1
                    break
                }
            }
            
            isLegal = isLegal(matrix, x, y)
            if(!isLegal) matrix[x, y] == -1
        }

        return true
        
    }
    
    isLegal: func(m: Matrix, refX, refY: Int) -> Bool {
        
        v := m[refX, refY]
        
        // check column
        for(x in 0..m getWidth()) {
            if(x == refX) continue
            if(v == matrix[x, refY]) {
                //printf("[column] Not legal because there's another %d at (%d, %d)\n", v, x, refY)
                return false
            }
        }
        
        // check line
        for(y in 0..m getHeight()) {
            if(y == refY) continue
            if(v == matrix[refX, y]) {
                //printf("[line] Not legal because there's another %d at (%d, %d)\n", v, refX, y)
                return false
            }
        }
        
        return true
        
    }
    
}
