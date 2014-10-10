//
//  LightsOutGame.swift
//  LightsOutGame
//
//  Created by ynsy on 08/10/14.
//  Copyright (c) 2014 ynsy. All rights reserved.
//

import Foundation

var clickedCounter = 0
enum CellState {
    case Light, Dark
}
let GRID_SIZE = 5

class LightsOutGame {
    var cells: [[CellState]]
    var isLight: Bool
    
    init() {
        let cellRow = [CellState] (count: GRID_SIZE, repeatedValue: .Dark)
        cells = [[CellState]] (count: GRID_SIZE, repeatedValue: cellRow)
        isLight = true
    }
    
    func markCellAt(row: Int, col: Int) {
        clickedCounter++
        if row >= 0 && col >= 0 && row < GRID_SIZE && col < GRID_SIZE {
            updateGameStateFor(row, col: col)
        }
    }
    
    private func updateGameStateFor (row: Int, col: Int){
        if row > 0{
            cellStateChanger(row-1, col: col, cellState: cells[row-1][col])
        }
        if row+1 < GRID_SIZE{
            cellStateChanger(row+1, col: col, cellState: cells[row+1][col])
        }
        if col > 0{
            cellStateChanger(row, col: col-1, cellState: cells[row][col-1])
        }
        if col+1 < GRID_SIZE{
            cellStateChanger(row, col: col+1, cellState: cells[row][col+1])
        }
        cellStateChanger(row, col: col, cellState: cells[row][col])
    }
    
    func cellStateChanger(row: Int, col: Int, cellState: CellState){
        if cellState == .Dark {
            cells[row][col] = .Light
        }else {
            cells[row][col] = .Dark
        }
    }
    
    func startEasyMode(){
        clickedCounter = 0
        for row in 0..<GRID_SIZE {
            for col in 0..<GRID_SIZE {
                cells[row][col] = .Light
            }
        }
    }
    
    func startHardMode(){
        clickedCounter = 0
        for row in 0..<GRID_SIZE {
            for col in 0..<GRID_SIZE {
                cells[row][col] = .Dark
            }
        }
        //make randomly Light for 4 cells
        for i in 0..<4{
            cells[random()%5][random()%5] = .Light
        }
    }
    
    func checkWinSituation() -> Bool{
        var count = 0
        for row in 0..<GRID_SIZE {
            for col in 0..<GRID_SIZE {
                if cells[row][col] == .Dark{
                    count++
                }
            }
        }
        return count == GRID_SIZE * GRID_SIZE
    }
}

