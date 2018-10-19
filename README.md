## UITableViewCell with custom focus style has incorrect width after scrolling fast

### Summary:
UITableViewCell size is incorrect when using a custom focus style and scrolling fast. The bug appears to be related to the affine transformation being applied when focus updates.

It does not matter what affine transformation is being applied: scale will have the wrong size, a rotation will have the wrong the rotation, etc.

I did discover the following thread on Apple Developer forums but it's proposed solution did not work:
https://forums.developer.apple.com/thread/48813

![bug pic](images/TvOSTableViewCellFocusBug.png)

![bug gif](images/TvOSTableViewCellFocusBug.gif)

### Steps to Reproduce:
1) Run the demo app: https://github.com/cgoldsby/TvOSTableViewCellFocusBug
2) Using the simulator Apple Remote or a paired Apple Remote scroll up and down

or

1) Create a table view cell with `focusStyle == .custom`
2) Using `UIFocusAnimationCoordinator` apply an affine transform when focusing & unfocusing (identity)

```swift
override func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    if let cell = context.previouslyFocusedItem as? UITableViewCell {
        coordinator.addCoordinatedFocusingAnimations({
            _ in
            cell.transform = .identity
        })
    }

    if let cell = context.nextFocusedItem as? UITableViewCell {
        coordinator.addCoordinatedFocusingAnimations({
            _ in
            cell.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
        })
    }
}
```

3) Run app
4) Using the simulator Apple Remote or a paired Apple Remote scroll up and down

### Expected Results:
✅ When the cell is focused the scale transformation is applied and the cell appears larger.
✅ When the cell is unfocused the identity transformation is applied and the cell returns to its original size.

### Actual Results:
✅ When the cell is focused the scale transformation is applied and the cell appears larger.
❌ When the cell is unfocused the identity transformation is not applied and the cell size is incorrect.

### Version/Build:
Xcode Version 10.0 (10A254a)

### Configuration:
Xcode Version 10.0 (10A254a), Apple TV simulator, tvOS 12. Also, reproducible with tvOS 11 and Xcode 9.4.1
