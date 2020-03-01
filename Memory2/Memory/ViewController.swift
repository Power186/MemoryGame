//
//  ViewController.swift
//  Memory
//
//  Created by Scott on 2/24/20.
//  Copyright © 2020 Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
// Updates the flip count label each time a card is flipped or clicked.
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
// Label displaying the flip count.
    @IBOutlet weak var flipCountLabel: UILabel!
    
// A collection of buttons that represent the card.
    @IBOutlet var cardButtons: [UIButton]!
    


// Accesses the emoji collection when a button/card is clicked and updates the flip count label.
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // A collection of emojis that can be displayed on a card.
    var emojiChoices = ["👻", "😱", "😈", "🎃", "👽", "🙀", "🍬", "🍭", "🍫"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        
        return emoji[card.identifier] ?? "?"
    }
    
}


