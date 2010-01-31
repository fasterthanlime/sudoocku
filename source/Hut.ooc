
Hut: class {
    
    value: Int // -1 = unsure
    hypo: Bool[9]
    
    init: func(=value) {
        for(i in 0..9) hypo[i] = true
    }
    
    clone: func -> This {
        copy := new(value)
        for(i in 0..9) { copy hypo[i] = hypo[i] }
        copy
    }
    
    setValue: func (=value) {}
    getValue: func -> Int { value }
    
    impossible: func (value: Int) -> Bool {
        if(hypo[value - 1]) {
            hypo[value - 1] = false
            return true
        }
        return false
    }
    
    isPossible: func (value: Int) -> Bool { hypo[value - 1] }
    
    sure:   func -> Bool { value != -1 }
    unsure: func -> Bool { value == -1 }
    
    hesitation: func -> Int {
        if(sure()) return -1
        hesit := 0
        for(i in 0..9) {
            if(hypo[i]) hesit += 1
        }
        hesit
    }
    
}
