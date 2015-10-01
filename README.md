# Apropos
Semantic Segues for Swift

Segueable provides a mechanism to build meaningful segue identifiers without
having to compare hard-coded strings everywhere.  An object's segueRoot is
a name describing its type, like a CoreData entity name. Your model classes
can implement this protocol, and you provide extensions to the Segueable
protocol for use in your application.

For example, if you have Apple and Banana classes, you might have segues
corresponding to actions such as pick, peel, or eat.  Your application's
extensions of Segueable would look like this:

```swift
extension Segueable {
    var pickSegueIdentifier: String { return "pick" + segueNoun }
    var peelSegueIdentifier: String { return "peel" + segueNoun }
    var eatSegueIdentifier: String { return "eat" + segueNoun }
}
```

Given this, if you have a table view displaying different types of fruit to
pick, you can easily perform the appropriate action for that type of fruit:

```swift
func tableView(tableView: UITableView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
    guard let selectedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? Segueable else { return }
    let sender = tableView.cellForRowAtIndexPath(indexPath)
    performSegueWithIdentifier(selectedObject.pickSegueIdentifier, sender: sender)
}
```

A similar pattern can be used for types:

```swift
extension SeguableType {
    static var pickSegueIdentifier: String { return "pick" + segueNoun }
    static var peelSegueIdentifier: String { return "peel" + segueNoun }
    static var eatSegueIdentifier: String { return "eat" + segueNoun }
}
```

This lets you avoid hard-coding strings in your preperForSegue methods etc.:

```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else { return }
    switch identifier {
    case Apple.pickSegueIdentifier:
        ...
    case Apple.peelSegueIdentifier:
        ...
    case Banana.pickSegueIdentifier:
        ...
    }
}
```

MIT licensed, cut-and-paste friendly.

[Apropos.swift](https://github.com/jberkman/Apropos/blob/master/Apropos/Apropos.swift)
