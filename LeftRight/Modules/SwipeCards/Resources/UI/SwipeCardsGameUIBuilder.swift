//
//  SwipeCardsGameUIBuilder.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 03/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class SwipeCardsGameUIBuilder {
    
    unowned var baseView: UIView

    init(baseView: UIView) {
        self.baseView = baseView
    }
    
    func build() -> SwipeCardsGameUI {
        baseView.backgroundColor = .white
        let cardsContainer = setupCardsContainer()
        
        let bottomContainer = setupBottomContainer(cardsContainer: cardsContainer)
        let directionsLabel = setupDirectionsLabel(bottomContainer: bottomContainer)
        let scoreLabel = setupScoreLabel(bottomContainer: bottomContainer)
        
        
        return SwipeCardsGameUI(scoreLabel: scoreLabel, directionLabel: directionsLabel, cardsContainer: cardsContainer)
    }
}

private extension SwipeCardsGameUIBuilder {
    
    func setupCardsContainer() -> UIView {
        let cardsContainer = SwipeCardsComponentsFactory.makeCardsContainer()
        baseView.addSubview(cardsContainer)
        NSLayoutConstraint.activate([
            cardsContainer.leadingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            cardsContainer.trailingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
            cardsContainer.topAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.topAnchor, constant: 32.0)
        ])
        return cardsContainer
    }
    
    func setupBottomContainer(cardsContainer: UIView) -> UIView {
        let bottomContainer = UIView()
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(bottomContainer)
        
        NSLayoutConstraint.activate([
            bottomContainer.topAnchor.constraint(equalTo: cardsContainer.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: baseView.safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 120.0)
        ])
        
        return bottomContainer
    }
    
    func setupDirectionsLabel(bottomContainer: UIView) -> UILabel {
        let directionLabel = SwipeCardsComponentsFactory.makeDirectionLabel()
        directionLabel.numberOfLines = 1
        directionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        bottomContainer.addSubview(directionLabel)
        NSLayoutConstraint.activate([
            directionLabel.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            directionLabel.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor)
        ])
        return directionLabel
    }
    
    func setupScoreLabel(bottomContainer: UIView) -> UILabel {
        let scoreLabel = SwipeCardsComponentsFactory.makeScoreLabel()
        //baseView.addSubview(scoreLabel)
        //NSLayoutConstraint.activate([
        //    scoreLabel.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 32.0),
        //    scoreLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -32.0)
        //])
        return scoreLabel
    }
}


