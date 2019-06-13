//
//  CellProtocol.swift
//  HappyPawsiOS
//
//  Created by Bryam  on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

