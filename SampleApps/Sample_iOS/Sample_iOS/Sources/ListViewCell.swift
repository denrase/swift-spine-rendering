//
//  ListViewCell.swift
//  Sample_iOS
//
//  Created by Denis Andrašec on 27.03.24.
//

import FoundationExtension
import Logging
import SpineSharedStructs
import SpineSwift

import UIKit

final class ListViewCell: UITableViewCell {
    
    weak var spineView: SpineView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(metalStack: SpineMetalStack, skeleton: SpineSkeleton, animation: String?) {
        guard spineView == nil else {
            return
        }
        let cameraRect = CGRect(
            origin: CGPoint(x: -350, y: -250),
            size: CGSize(width: 700, height: 1000)
        )
        let spineView = SpineView(
            metalStack: metalStack,
            currentMediaTimeProvider: ObjectStorage.shared.currentMediaTimeProvider,
            cameraFrame: ScreenFrame(rect: cameraRect),
            logger: ObjectStorage.shared.logger
        )
        
        spineView.frame = bounds
        spineView.translatesAutoresizingMaskIntoConstraints = false
        spineView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(spineView)
        
        self.spineView = spineView
        
        spineView.add(skeleton: skeleton)
        if let animation {
            try! skeleton.setAnimation(named: animation, loop: true, completion: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spineView?.pause()
    }
}
