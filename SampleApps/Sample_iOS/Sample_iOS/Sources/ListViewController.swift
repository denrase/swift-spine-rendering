//
//  ListViewController.swift
//  Sample_iOS
//
//  Created by Denis Andrašec on 27.03.24.
//

import FoundationExtension
import Logging
import SpineSharedStructs
import SpineSwift
import UIKit

final class ListViewController: UIViewController {
    
    weak var tableView: UITableView!
    var metalStack: SpineMetalStack!
    
    var skeletons = [SpineSkeleton]()
    
    init() {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view = tableView
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spine List Sample"
        
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listViewCell")
        tableView.rowHeight = 500
        
        let logger = ObjectStorage.shared.logger
        
        do {
            metalStack = try SpineMetalStack()
            ObjectStorage.shared.setupSkeletonSwiftRuntime(with: metalStack.generalMetalStack)
            
            logger.info("Loading sekeltons...")

            let skeletonsLoader = ObjectStorage.shared.skeletonsLoader
            let skeletonsFodler = Bundle.main.resourceURL!.appending(path: "Skeletons", directoryHint: .isDirectory)
            skeletons = try skeletonsLoader.load(from: skeletonsFodler)

            logger.info("Found \(skeletons.count) skeletons: \(skeletons.map { $0.name })")
        } catch {
            print(error)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12 * 4 // Mehrere dutzend dieser views...
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell") as? ListViewCell else {
            return UITableViewCell()
        }
        let skeleton = skeletons[indexPath.row % skeletons.count]
        cell.setup(metalStack: metalStack, skeleton: skeleton, animation: skeleton.animations.randomElement()?.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let listViewCell = cell as? ListViewCell
        listViewCell?.spineView?.play()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let listViewCell = cell as? ListViewCell
        listViewCell?.spineView?.pause()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Push detail
    }
}
