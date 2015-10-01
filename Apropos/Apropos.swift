//
//  Apropos.swift
//  Apropos
//
//  Created by jacob berkman on 2015-09-30.
//  Copyright © 2015 jacob berkman. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

/*

    Segueable and SegueableType provide a mechanism to build meaningful segue
    identifiers without having to compare or duplicate hard-coded strings
    anywhere.

    A types's segueTypeNoun is a name describing its type, like a CoreData
    entity name. Your model classes can implement this protocol, and you provide
    extensions to the Segueable and SegueableType protocol for use in your
    application as you see fit. Adopting the protocol is trivial:

    extension Apple: SegueableType, Segueable {
        static let segueTypeNoun = "Apple"
    }

    extension Banana: SegueableType, Segueable {
        static let segueTypeNoun = "Banana"
    }

    If your objects are fruits, you can create segue identifiers for the actions
    available in your UI:

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

    Given this, if you have a table view displaying different types of fruit to
    pick, you can easily perform the appropriate action for that type of fruit:

    func tableView(tableView: UITableView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        guard let selectedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? Segueable else { return }
        let sender = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier(selectedObject.pickSegueIdentifier, sender: sender)
    }

    Because strings are Segueable too, you could also use your fetch request to
    determine which segue to use:

    func tableView(tableView: UITableView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        guard let entityName = fetchedResultsController.fetchRequest.entityName else { return }
        let sender = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier(entityName.pickSegueIdentifier, sender: sender)
    }

    You can also avoid hard-coding strings in your preperForSegue methods etc.:

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

 */

public protocol SegueableType {
    static var segueTypeNoun: String { get }
}

extension SegueableType {
    var segueNoun: String { return self.dynamicType.segueTypeNoun }
}

public protocol Segueable {
    var segueNoun: String { get }
}

extension String: Segueable {
    public var segueNoun: String { return self }
}
