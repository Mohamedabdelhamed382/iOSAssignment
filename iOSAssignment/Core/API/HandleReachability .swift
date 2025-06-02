//
//  HandleReachability.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isConnected: Bool = false

    var onStatusChange: ((Bool) -> Void)?

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let connected = path.status == .satisfied
            self?.isConnected = connected
            self?.onStatusChange?(connected)
        }
        monitor.start(queue: queue)
    }
}
