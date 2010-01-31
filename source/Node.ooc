import structs/[List, ArrayList]
import Matrix, Path

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
    
    holes: func -> Int {
        
        holes := 0
        for(y in 0..9) for(x in 0..9) {
            if(matrix[x, y] unsure()) holes += 1
        }
        holes
        
    }
    
    split: func -> Bool {
        
        bestX = -1, bestY = -1, minHesit = 9 : Int
        
        for(y in 0..9) for(x in 0..9) {
            hut := matrix[x, y]
            if(hut sure()) continue
            hesit := hut hesitation()
            if(hesit < minHesit) {
                bestX = x
                bestY = y
                minHesit = hesit
            }
        }
        
        if(bestX != -1 && bestY != -1 && minHesit != -1) {
            //printf("best = (%d, %d), with hesit %d\n", bestX, bestY, minHesit)
            hut := matrix[bestX, bestY]
            
            for(val in 1..10) {
                if(hut isPossible(val)) {
                    copy := clone()
                    copy matrix[bestX, bestY] setValue(val)
                    add(copy)
                }
            }
            return true
        }
        
        return false
        
    }
    
    crossOut: func {
        
        for(y in 0..9) for(x in 0..9) {
            v := matrix[x, y]
            if(v unsure()) continue
            
            for(x2 in 0..9) {
                if(x == x2) continue
                v2 := matrix[x2, y]
                if(v2 unsure() && v2 impossible(v getValue())) {
                    //printf("(%d, %d) can't be a %d\n", x2, y, v getValue())
                }
            }
            
            for(y2 in 0..9) {
                if(y == y2) continue
                v2 := matrix[x, y2]
                if(v2 unsure() && v2 impossible(v getValue())) {
                    //printf("(%d, %d) can't be a %d\n", x, y2, v getValue())                    
                }
            }
        }
        
        for(Y in 0..3) for(X in 0..3) {
            for(x in 0..3) for(y in 0..3) {
                v := matrix[X*3 + x, Y*3 + y]
                if(v unsure()) continue
                
                for(x2 in 0..3) for(y2 in 0..3) {
                    if(x2 == x && y2 == y) continue
                    v2 := matrix[X*3 + x2, Y*3 + y2]
                    if(v2 unsure()) {
                        v2 impossible(v getValue())
                        //printf("(%d, %d) can't be a %d\n", X*3 + x2, Y*3 + y2, v getValue())
                    }
                }
            }
        }
        
    }
    
    findUnique: func -> Bool {
        
        for(y in 0..9) for(x in 0..9) {
            
            h := matrix[x, y]
            if(h sure()) continue
            
            value := -1
            for(i in 1..10) {
                if(h isPossible(i)) {
                    if(value == -1) {
                        //printf("(%d, %d) could be %d\n", x, y, i)
                        value = i
                    } else {
                        value = -1
                        break
                    }
                }
            }
            
            if(value != -1) {
                //printf("Deduced (%d, %d) = %d!\n", x, y, value)
                matrix[x, y] setValue(value)
                return true
            }
        }
        
        return false
        
    }
    
    swapRandomly: func (howMany: Int, holy: Matrix) {
        
        //printf("Should swap %d numbers\n", howMany)
        
        for(i in 0..howMany) {
            okay := false
            x, y: Int
            while(!okay) {
                x = rand() % 9
                y = rand() % 9
                okay = (holy[x, y] unsure())
            }
            
            okay = false
            x2, y2: Int
            while(!okay) {
                x2 = rand() % 9
                y2 = rand() % 9
                okay = (holy[x2, y2] unsure())
            }
            
            //printf("Swapping (%d, %d) with (%d, %d)\n", x, y, x2, y2)
            tmp := matrix[x, y] getValue()
            matrix[x, y] setValue(matrix[x2, y2] getValue())
            matrix[x2, y2] setValue(tmp)
        }
        
    }
    
}
