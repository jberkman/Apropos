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

import CoreData

/*

    Segueable provides a mechanism to build meaningful segue identifiers without
    having to compare hard-coded strings everywhere.  An object's segueRoot is
    a name describing its type, like a CoreData entity name. Your model classes
    can implement this protocol, and you provide extensions to the Segueable
    protocol for use in your application.

    For example, if you have Apple and Banana classes, you might have segues
    corresponding to actions such as pick, peel, or eat.  Your application's
    extensions of Segueable would look like this:

    extension Segueable {
        var pickSegueIdentifier: String { return "pick" + segueNoun }
        var peelSegueIdentifier: String { return "peel" + segueNoun }
        var eatSegueIdentifier: String { return "eat" + segueNoun }
    }

    Given this, if you have a table view displaying different types of fruit to
    pick, you can easily perform the appropriate action for that type of fruit:

    func tableView(tableView: UITableView, didSelectCellAtIndexPath indexPath: NSIndexPath) {
        guard let selectedObject = fetchedResultsController.objectAtIndexPath(indexPath) as? Segueable else { return }
        let sender = tableView.cellForRowAtIndexPath(indexPath)
        performSegueWithIdentifier(selectedObject.pickSegueIdentifier, sender: sender)
    }

    A similar pattern can be used for types:

    extension SeguableType {
        static var pickSegueIdentifier: String { return "pick" + segueNoun }
        static var peelSegueIdentifier: String { return "peel" + segueNoun }
        static var eatSegueIdentifier: String { return "eat" + segueNoun }
    }

    This lets you avoid hard-coding strings in your preperForSegue methods etc.:

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

public protocol Segueable {
    var segueNoun: String { get }
}

public protocol SegueableType {
    static var segueNoun: String { get }
}

extension String: Segueable {
    public var segueNoun: String { return self }
}

extension NSManagedObject: Segueable {
    public var segueNoun: String { return entity.name ?? "Object" }
}
