//: A UIKit based Playground for presenting user interface
  
import UIKit
//import PlaygroundSupport
//
//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .white
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//
//        view.addSubview(label)
//        self.view = view
//    }
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()


class SomeClass {
    var p1: String = ""
}

struct SomeStruct {
    var p1: String
}

let a1 = SomeClass()
var a2 = SomeStruct(p1: "a2")

a1.p1 = "asdsad"
a2.p1 = "asfdf"

let a: Int? = Optional(8)

//guard let a = a else {
//
//}

//if let a = a {
//    a
//}
