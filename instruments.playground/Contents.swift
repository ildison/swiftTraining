//: Playground - noun: a place where people can play

let inst = Instrument(brand: "yo")
let musi = Music(notes: ["asdad", "123", "*&^%"])

inst.play(musi)

class Piano:  Instrument  {
    let hasPedals: Bool
    // 2
    static let whiteKeys = 52
    static let blackKeys = 36
    // 3
    init(brand: String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        // 4
        super.init(brand: brand)
    }
    // 5
    override func tune() -> String {
        return "Piano standard tuning for \(brand)."
    }
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals."
        } else {
            return "Play piano notes \(preparedNotes) without pedals."
        }
    }
}

// 1
let piano = Piano(brand: "Yamaha", hasPedals: true)
piano.tune()
// 2
let music = Music(notes: ["C", "G", "F"])
piano.play(music, usingPedals: false)
// 3
piano.play(music)
// 4
//Piano.whiteKeys
Piano.blackKeys

class Guitar: Instrument  {
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}

class AcousticGuitar: Guitar  {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on frets \(preparedNotes)."
    }
}

let acousticGuitar = AcousticGuitar(brand: "Roland", stringGauge: "hz")
acousticGuitar.play(music)

class Amplifier  {
    // 2
    private var _volume: Int
    // 3
    private(set) var isOn: Bool
    
    init() {
        isOn = false
        _volume = 0
    }
    // 4
    func plugIn() {
        isOn = true
    }
    
    func unplug() {
        isOn = false
    }
    // 5
    var volume: Int {
        // 6
        get {
            return isOn ? _volume : 0
        }
        // 7
        set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}

let ampl = Amplifier()
ampl.isOn
ampl.volume = 21
ampl.plugIn()
ampl.volume

// 1
class ElectricGuitar: Guitar  {
    // 2
    let amplifier: Amplifier
    // 3
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    // 4
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    // 5
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}

class BassGuitar: Guitar  {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play bass line \(preparedNotes) at volume \(amplifier.volume)."
    }
}

let amplifier = Amplifier()
let electricGuitar = ElectricGuitar(brand: "Gibson",
                                    stringGauge: "medium",
                                    amplifier: amplifier)
electricGuitar.tune()

let bassGuitar = BassGuitar(brand: "Fender",
                            stringGauge: "heavy",
                            amplifier: amplifier)
bassGuitar.tune()

// Обратите внимание, что из-за семантики ссылки на класс усилитель является общим ресурсом между этими двумя гитарами.

bassGuitar.amplifier.volume
electricGuitar.amplifier.volume
bassGuitar.amplifier.unplug()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume
bassGuitar.amplifier.plugIn()
bassGuitar.amplifier.volume
electricGuitar.amplifier.volume

class Band  {
    let instruments: [Instrument]
    
    init(instruments: [Instrument]) {
        self.instruments = instruments
    }
    
    func perform(_ music: Music) {
        for instrument in instruments {
            instrument.perform(music)
        }
    }
}

let instruments = [piano, acousticGuitar,
                   electricGuitar, bassGuitar]

let band = Band(instruments: instruments)
band.perform(music)



