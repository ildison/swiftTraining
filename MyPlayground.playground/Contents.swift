enum error: Error {
    case InvalidArgumentException
}

class Node {
    var data: Int
    var next: Node?
    init(_ data: Int) {
        self.data = data
    }
    func len() -> Int {
        var len = 0
        var node: Node? = self
        while node != nil {
            len += 1
            node = node?.next
        }
        return(len)
    }
}

func push(_ head:Node?, _ data:Int) -> Node {
    let freshNode = Node(data)
    freshNode.next = head
    return freshNode
}

func buildOneTwoThree() -> Node {
    var node: Node? = nil
    for data in stride(from: 3, through: 1, by: -1) {
        node = push(node, data)
    }
    return node!
}

func getNth(_ head: Node?, _ index: Int) throws -> Node? {
    guard var node: Node = head else {
        throw error.InvalidArgumentException
    }
    guard index >= 0 && index < node.len() else {
        throw error.InvalidArgumentException
    }
    for _ in 0..<index {
        node = node.next!
    }
    return(node)
}

let trstNode = buildOneTwoThree()

let ret = try? getNth(trstNode, 3)

ret??.data

//var optionalString: String? = "Hello"
//print(optionalString == nil)
//var optionalName: String? = nil
//var greeting = "Hello!"
//if let name = optionalName {
//    greeting = "Hello, \(name)"
//    print(greeting)
//}
//else {
//    greeting = "Hello, nil"
//    print(greeting)
//}



//enum PrinterError: Error {
//    case outOfPaper
//    case noToner
//    case onFire
//}
//
//func send(job: Int, toPrinter printerName: String) throws -> String {
//    if printerName == "Never Has Toner" {
//        throw PrinterError.noToner
//    }
//    return "Job sent"
//}
//
////do {
////    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
////    print(printerResponse)
////} catch {
////    print(error)
////}
//
//do {
//    let printerResponse = try send(job: 1440, toPrinter: "Never Has Toner")
//    print(printerResponse)
//} catch PrinterError.onFire {
//    print("I'll just put this over here, with the rest of the fire.")
//} catch let printerError as PrinterError {
//    print("Printer error: \(printerError).")
//} catch {
//    print(error)
//}



//func length(_ head: Node?) -> Int {
//    var len = 0
//    var node = head
//
//    while node != nil {
//        len += 1
//        node = node?.next
//    }
//    return(len)
//}
//
//func count(_ head: Node?, _ data: Int) -> Int {
//    var count = 0
//    var node = head
//
//    while node != nil {
//        if data == node?.data { count += 1 }
//        node = node?.next
//    }
//    return(count)
//}
























