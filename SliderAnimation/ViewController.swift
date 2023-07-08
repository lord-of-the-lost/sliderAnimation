//
//  ViewController.swift
//  SliderAnimation
//
//  Created by Николай Игнатов on 08.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTapped), for: .touchUpInside)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(blueView)
        view.addSubview(slider)
    }
    
    private func setupConstraints() {
        let marginConstant: CGFloat = 20
        
        view.layoutMargins = UIEdgeInsets(top: marginConstant, left: marginConstant, bottom: 0, right: marginConstant)
        
        let layoutMargins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: 75),
            blueView.heightAnchor.constraint(equalToConstant: 75),
            
            slider.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 80),
            slider.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor),
        ])
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let scaleConstant: CGFloat = 1.0 + CGFloat(sender.value) * 0.5
        
        let rotationAngle: CGFloat = CGFloat(sender.value) * .pi / 2.0
        
        let availableWidth = view.frame.width - view.layoutMargins.left - blueView.frame.width - view.layoutMargins.right
        
        let newCenterX = view.layoutMargins.left + blueView.frame.width / 2.0 + availableWidth * CGFloat(sender.value)
        
        UIView.animate(withDuration: 0.3) {
            self.blueView.transform = CGAffineTransform(scaleX: scaleConstant, y: scaleConstant).rotated(by: rotationAngle)
            self.blueView.center.x = newCenterX
        }
    }
    
    @objc private func sliderTapped(_ sender: UISlider) {
        UIView.animate(withDuration: 0.3) {
            self.blueView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).rotated(by: .pi / 2)
            self.blueView.center.x = self.view.frame.width - self.view.layoutMargins.left - self.blueView.frame.width / 2
            sender.setValue(sender.maximumValue, animated: true)
        }
    }
}

