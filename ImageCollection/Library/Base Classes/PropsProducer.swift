//
//  PropsProducer.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

protocol PropsProducer {
    associatedtype Props
    
    var propsRelay: Observable<Props> { get }
}

protocol PropsConsumer {
    associatedtype Props
    
    var props: Props { get set }
}

extension PropsConsumer where Self: NSObject {
    func bind<Producer: PropsProducer>(to propsProducer: Producer) where Producer.Props == Props {
        self.holdRef(propsProducer, by: "props_producer")
        
        propsProducer.propsRelay
            .bind { [weak self] props in
                self?.props = props
            }
    }
}

extension NSObject {
    func holdRef(_ object: Any, by key: String) {
        var mutableKey = key
        objc_setAssociatedObject(self, &mutableKey, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
