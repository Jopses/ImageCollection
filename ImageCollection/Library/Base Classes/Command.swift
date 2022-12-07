//
//  Command.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

final class CommandWith<T> {
    private let commandClosure: (T) -> ()

    init(closure: @escaping (T) -> ()) {
        self.commandClosure = closure
    }

    init() {
        self.commandClosure = { value in }
    }

    func execute(with param: T) {
        commandClosure(param)
    }
}

typealias Command = CommandWith<Void>

extension CommandWith where T == Void {
    func execute() {
        self.execute(with: ())
    }

    static func create<Object: AnyObject>(from owner: Object, _ block: @escaping (Object) -> () -> ()) -> Command {
        return CommandWith { [weak owner] _ in
            guard let this = owner else {
                return
            }
            block(this)()
        }
    }
}

extension CommandWith {
    static func create<Object: AnyObject>(from owner: Object, _ block: @escaping (Object) -> (T) -> ()) -> CommandWith<T> {
        return CommandWith { [weak owner] in
            guard let this = owner else {
                return
            }
            block(this)($0)
        }
    }
    
    static var empty: CommandWith<T> {
        return CommandWith { _ in }
    }
}
