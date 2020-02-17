//
//  BorderButton.swift
//  Calculate
//
//  Created by Chugtai Ormund on 17/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { return layer.cornerRadius  }
    }
}
