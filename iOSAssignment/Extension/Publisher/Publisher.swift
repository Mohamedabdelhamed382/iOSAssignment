//
//  Publisher.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//

import Combine
import UIKit

extension Publisher where Self.Failure == Never {
    public func sinkOnMain(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        self
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: receiveValue)
    }
    
    
    public func sinkOnRunLoop(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        self
            .receive(on: RunLoop.main)
            .sink(receiveValue: receiveValue)
    }
}
