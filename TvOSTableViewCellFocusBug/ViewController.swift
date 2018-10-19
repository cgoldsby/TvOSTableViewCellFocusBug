//
//  ViewController.swift
//  TvOSTableViewCellFocusBug
//
//  Created by Christopher Goldsby on 10/19/18.
//  Copyright © 2018 Christopher Goldsby. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        cell.focusStyle = .custom
        applyUnfocusStyle(cell)
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.previouslyFocusedItem as? UITableViewCell {
            coordinator.addCoordinatedFocusingAnimations({
                _ in
                self.applyUnfocusStyle(cell)
            })
        }

        if let cell = context.nextFocusedItem as? UITableViewCell {
            coordinator.addCoordinatedFocusingAnimations({
                _ in
                self.applyFocusStyle(cell)
            })
        }
    }

    // MARK: - Cell Style

    private func applyUnfocusStyle(_ cell: UITableViewCell) {
        cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cell.transform = .identity
    }

    private func applyFocusStyle(_ cell: UITableViewCell) {
        cell.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        cell.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
    }
}
