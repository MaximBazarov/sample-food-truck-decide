//
//  Int+Identifiable.swift
//  Food Truck
//
//  Created by Anton Kolchunov on 21.08.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

extension Int: Identifiable {
    public var id: Int { self }
}
