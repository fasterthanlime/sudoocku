import structs/List

version(unix || apple) {
    Matrix lowerLeft  = "└"
    Matrix lowerRight = "┘"
    Matrix upperLeft  = "┌"
    Matrix upperRight = "┐"
    Matrix horiz      = "─"
    Matrix vert       = "│"
}

version (!(unix || apple)) {
    Matrix lowerLeft  = "\\"
    Matrix lowerRight = "/"
    Matrix upperLeft  = "/"
    Matrix upperRight = "\\"
    Matrix horiz      = "-"
    Matrix vert       = "|"
}

Matrix: class {
    
    lowerLeft, upperLeft, lowerRight, upperRight, horiz, vert : static String
    
    width, height: Int
    data: Int*
    
    init: func ~fromSize (=width, =height) {
        data = gc_malloc(Int size * width * height)
    }
    
    init: func ~copy (src: This) {
        this(src width, src height)
        memcpy(this data, src data, Int size * width * height)
    }
    
    init: func ~from2DArray (=width, =height, data: Int*) {
        init~fromSize(width, height)
        memcpy(this data, data, Int size * width * height)
    }
    
    clone: func -> This { new(this) }
    
    identity: static func (size: Int) -> This {
        n := new(size, size)
        for(i in 0..size) n[i, i] = 1
        n
    }
    
    set: func (x, y: Int, val: Int) {
        data[x + y * width] = val
    }
    
    get: func (x, y: Int) -> Int {
        return data[x + y * width]
    }
    
    rowMul: func (row: Int, factor: Int) {
        for(x in 0..width) {
            this[x, row] = factor * this[x, row]
        }
    }
    
    rowAdd: func (srcRow, dstRow: Int, factor: Int) {
        for(x in 0..width) {
            this[x, dstRow] = this[x, dstRow] + this[x, srcRow] * factor
        }
    }
    
    rowSwap: func (row1, row2: Int) {
        for(x in 0..width) {
            tmp := this[x, row1]
            this[x, row1] = this[x, row2]
            this[x, row2] = tmp
        }
    }

    sub: func (m2: This) -> This {
        m1 := this
        m3 := This new(width, height)
        for(y in 0..height) {
            for(x in 0..width) {
                m3 set(x, y, m1 get(x, y) - m2 get(x, y))
            }
        }
        return m3
    }
    
    mul: func (m2: This) -> This {
        m1 := this
        m3 := This new(m2 width, m1 height)
        for(m2x in 0..m2 width) {
            for(m1y in 0..m1 height) {
                sum := 0.0
                for(m2y_m1x in 0..m2 height) {
                    sum += m1 get(m2y_m1x, m1y) * m2 get(m2x, m2y_m1x)
                }
                m3 set(m2x, m1y, sum)
            }
        }
        return m3
    }
    
    print: func {
        xspacing := 3
        
        printf("%s", upperLeft)
        for(x in 0..(width * xspacing + 8)) printf("%s", horiz)
        printf("%s\n", upperRight)
        
        for(y in 0..height) {
            printf("%s", vert)
            for(x in 0..width) {
                val := get(x, y)
                if(val == -1) {
                    printf("  .")
                } else {
                    printf("  %d", val)
                }
                if((x + 1) % 3 == 0) printf("  %s", vert)
            }
            printf("\n")
            
            if(y != (height - 1) && (y + 1) % 3 == 0) {
                printf(" ")
                for(x in 0..(width * xspacing + 8)) printf("%s", horiz)
                printf("\n")
            }
        }
        
        printf("%s", lowerLeft)
        for(x in 0..(width * xspacing + 8)) {
            printf("%s", horiz)
        }
        printf("%s\n", lowerRight)
    }
    
    getWidth:  func -> Int { width }
    getHeight: func -> Int { height }
    
    isSquare: func -> Bool { getWidth() == getHeight() }

}

operator *   (m1, m2: Matrix) -> Matrix { m1 mul(m2) }
operator -   (m1, m2: Matrix) -> Matrix { m1 sub(m2) }
operator []  (m: Matrix, x, y: Int) -> Int    { m get(x, y) }
operator []= (m: Matrix, x, y: Int, val: Int) { m set(x, y, val) }
