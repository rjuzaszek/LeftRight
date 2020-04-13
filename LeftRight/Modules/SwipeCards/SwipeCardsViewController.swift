//
//  SwipeCardsViewController.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class SwipeCardsViewController: UIViewController {
    
    //MARK: - Public properties
    
    weak var coordinator: SwipeCardsCoordination?
    var viewModel: SwipeCardsViewModelProtocol?
    var gameUI: SwipeCardsGameUI!
    
    //MARK: - Private properties
    
    private var currentSwipeDirection = SwipeCards.Direction.left
    private var score = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        gameUI = SwipeCardsGameUIBuilder(baseView: view).build()
        setupGameInitialStatus()
        navigationController?.navigationBar.topItem?.title = ""
    }
}

//MARK: - Private functions
private extension SwipeCardsViewController {
    
    func setupGameInitialStatus() {
        setupInitialCards()
        setupGameInitialDirection()
    }
    
    func setupInitialCards() {
        let cards = [CardView(), CardView(), CardView(), CardView()]
        for (index,card) in cards.enumerated() {
            viewModel?.getNextCard(completion: { [weak self] model in
                card.setup(model: model)
                self?.addSwipeRecognizerToCard(card)
                if index == 0 {
                    self?.gameUI.cardsContainer.addSubview(card)
                } else {
                    self?.gameUI.cardsContainer.insertSubview(card, belowSubview: cards[index-1])
                }
                self?.gameUI.cardsContainer.setupFillingConstraints(card)
            })
        }
        setCardsAnimations()
    }
    
    func setupGameInitialDirection() {
        if let swipeDirection = viewModel?.getNextDirection() {
            currentSwipeDirection = swipeDirection
            gameUI.directionLabel.text = currentSwipeDirection.rawValue
        }
    }
    
    func makeNewCard(with model: SwipeCardModel) {
        let card = CardView()
        addSwipeRecognizerToCard(card)
        card.setup(model: model)
        gameUI.cardsContainer.insertSubviewWithConstraints(card, index: 0)
        setCardsAnimations()
    }
    
    func addSwipeRecognizerToCard(_ card: CardView) {
        let swipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipeCard))
        card.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    func setCardsAnimations() {
        for (index,card) in gameUI.cardsContainer.subviews.reversed().enumerated() {
            let index: CGFloat = CGFloat(index)
            let cardScale: CGFloat = max(0, 1 - index * SwipeCards.cardsScaleFactor)
            UIView.animate(withDuration: 0.3, animations: {
                card.transform = CGAffineTransform(scaleX: cardScale, y: cardScale)
            })
        }
    }
    
    func setupBackButton() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.title = ""
    }
    
    @objc func close() {
        coordinator?.close()
    }
    
    @objc func swipeCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? CardView else { return }
        switch sender.state {
        case .began:
            card.shouldRotateLeft = sender.location(ofTouch: 0, in: card).y > (card.bounds.height / 2)
            
        case .changed:
            let translation = sender.translation(in: card.superview)
            card.transform = transform(view: card, for: translation)
            
        case .ended:
            let cardVelocity = sender.velocity(in: card.superview).x
            let isDismissVelocity = abs(cardVelocity) > CGFloat(SwipeCards.dismissVelocity)
            
            switch currentSwipeDirection {
            case .left:
                if isDismissVelocity && cardVelocity < 0 || card.convert(card.center, to: view).x < CGFloat(SwipeCards.dismissPosition) {
                    dismissCard(card)
                    return
                } else if isDismissVelocity && cardVelocity > 0 || view.bounds.width - card.convert(card.center, to: view).x < CGFloat(SwipeCards.dismissPosition) {
                    WrongAnswerAnimation.animate(card)
                }
            case .right:
                if isDismissVelocity && cardVelocity > 0 || view.bounds.width - card.convert(card.center, to: view).x < CGFloat(SwipeCards.dismissPosition) {
                    dismissCard(card)
                    return
                } else if isDismissVelocity && cardVelocity < 0 || card.convert(card.center, to: view).x < CGFloat(SwipeCards.dismissPosition) {
                    WrongAnswerAnimation.animate(card)
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.transform = .identity
            })
            
        default:
            break
        }
    }
    
    func dismissCard(_ card: CardView) {
        card.removeFromSuperview()
        viewModel?.getNextCard(completion: { [weak self] model in
            self?.makeNewCard(with: model)
        })

        score += 1
        gameUI.scoreLabel.text = String(score)
        
        if let nextDirection = viewModel?.getNextDirection() {
            currentSwipeDirection = nextDirection
            UIView.animate(withDuration: 0.1, animations: {
                self.gameUI.directionLabel.alpha = 0.0
            }, completion: { _ in
                self.gameUI.directionLabel.text = self.currentSwipeDirection.rawValue
                self.gameUI.directionLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                UIView.animate(withDuration: 0.3, animations: {
                    self.gameUI.directionLabel.alpha = 1.0
                    self.gameUI.directionLabel.transform = .identity
                })
            })
        }
    }
    
    func transform(view: CardView, for translation: CGPoint) -> CGAffineTransform {
        let rotationDirection: CGFloat = view.shouldRotateLeft ? -1 : 1
        let moveAmount = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation = rotationDirection * sin(translation.x / (view.frame.width * 4.0))
        return moveAmount.rotated(by: rotation)
    }
}
