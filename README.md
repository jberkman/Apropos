# Apropos
[Apropos.swift](https://github.com/jberkman/Apropos/blob/master/Apropos/Apropos.swift): Semantic Segues for Swift. MIT licensed, cut-and-paste friendly.

Segueable and SegueableType provide a mechanism to build meaningful segue
identifiers without having to compare or duplicate hard-coded strings
anywhere.

A types's segueTypeNoun is a name describing its type, like a CoreData
entity name. Your model classes can implement this protocol, and you provide
extensions to the Segueable and SegueableType protocol for use in your
application as you see fit. Adopting the protocol is trivial:

```swift
extension Apple: SegueableType, Segueable {
    class var segueTypeNoun: String { return "Apple" }
}

extension Banana: SegueableType, Segueable {
    class var segueTypeNoun: String { return "Banana" }
}
```

If your objects are fruits, you can create segue identifiers for the actions
available in your UI:

```swift
private let pickVerb = "pick"
private let peelVerb = "peel"
private let eatVerb = "eat"

extension SegueableType {
    static var pickSegueIdentifier: String { return pickVerb + segueTypeNoun }
    static var peelSegueIdentifier: String { return peelVerb + segueTypeNoun }
    static var eatSegueIdentifier: String { return eatVerb + segueTypeNoun }
}

extension Segueable {
    var pickSegueIdentifier: String { return pickVerb + segueNoun }
    var peelSegueIdentifier: String { return peelVerb + segueNoun }
    var eatSegueIdentifier: String { return eatVerb + segueNoun }
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

Because strings are Segueable too, you could also use your fetch request to
determine which segue to use:

```swift
func tableView(tableView: UITableView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
    guard let entityName = fetchedResultsController.fetchRequest.entityName else { return }
    let sender = tableView.cellForRowAtIndexPath(indexPath)
    performSegueWithIdentifier(entityName.pickSegueIdentifier, sender: sender)
}
```

You can also avoid hard-coding strings in your preperForSegue methods etc.:

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
