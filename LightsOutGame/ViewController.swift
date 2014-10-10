//
//  ViewController.swift
//  LightsOutGame
//
//  Created by ynsy on 08/10/14.
//  Copyright (c) 2014 ynsy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gridCell = LightsOutGame()

    @IBOutlet var cellButtons: [UIButton]!
    
    @IBAction func cellButtonAction(sender: UIButton) {
        NSLog("%d", sender.tag)
        NSLog("%d, row: ", sender.tag / GRID_SIZE)
        NSLog("%d, col: ", sender.tag % GRID_SIZE)

        let row = sender.tag / GRID_SIZE
        let col = sender.tag % GRID_SIZE
        gridCell.markCellAt(row, col: col)
        refreshUI()
        showWinningSituation()
    }
    
    private func refreshUI(){
        for cell in cellButtons {
            let row = cell.tag / GRID_SIZE
            let col = cell.tag % GRID_SIZE
            clickedSituation.text = "Clicked \(clickedCounter) times."
            let state = gridCell.cells[row][col]
            switch state {
            case CellState.Dark:
                cell.setTitle(" ", forState: .Normal)
            case CellState.Light:
                cell.setTitle("🔆", forState: .Normal)
            }
        }
    }
   
    @IBAction func startEasyMode(sender: AnyObject) {
        enableAllButtons()
        gridCell.startEasyMode()
        refreshUI()
    }
    
    @IBAction func startHardMode(sender: AnyObject) {
        enableAllButtons()
        gridCell.startHardMode()
        refreshUI()
    }
   
    
    @IBOutlet weak var clickedSituation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableAllButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWinningSituation(){
        if gridCell.checkWinSituation() {
            for i in 0..<25 {
                if (i != 6 || i != 7 || i != 8 || i != 11 || i != 12 || i != 13) {
                    cellButtons[i].setTitle("#", forState: .Normal)
                }
            }
            cellButtons[6].setTitle("Y", forState: .Normal)
            cellButtons[7].setTitle("O", forState: .Normal)
            cellButtons[8].setTitle("U", forState: .Normal)
            
            cellButtons[11].setTitle("W", forState: .Normal)
            cellButtons[12].setTitle("I", forState: .Normal)
            cellButtons[13].setTitle("N", forState: .Normal)
            disableAllButtons()
        }
    }
    
    func disableAllButtons(){
        for i in 0..<25 {
            cellButtons[i].enabled = false
        }
    }
    
    func enableAllButtons(){
        for i in 0..<25 {
            cellButtons[i].enabled = true
        }
    }
    
}

