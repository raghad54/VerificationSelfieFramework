//
//  PreviewViewController.swift
//  VerificationSelfiee
//
//  Created by Raghad's Mac on 22/07/2024.
//

import UIKit

///doc: `PreviewViewController` is responsible for displaying the captured image to the user. It provides options to approve the image, which sends it back to the delegate, or to recapture another image. The class includes buttons for both actions and an image view to show the captured image.


public class PreviewViewController: UIViewController {

    // MARK: - Properties
    public var image: UIImage?
    public weak var delegate: PreviewViewControllerDelegate?
    
    private var imageView: UIImageView!
    private var acceptButton: UIButton!
    private var recaptureButton: UIButton!

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white

        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Approve", for: .normal)
        acceptButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.backgroundColor = .systemBlue
        acceptButton.layer.cornerRadius = 15
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(acceptButton)

        recaptureButton = UIButton(type: .system)
        recaptureButton.setTitle("Recapture", for: .normal)
        recaptureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        recaptureButton.setTitleColor(.white, for: .normal)
        recaptureButton.backgroundColor = .red
        recaptureButton.layer.cornerRadius = 15
        recaptureButton.addTarget(self, action: #selector(recaptureButtonPressed), for: .touchUpInside)
        recaptureButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recaptureButton)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            acceptButton.widthAnchor.constraint(equalToConstant: 120),
            acceptButton.heightAnchor.constraint(equalToConstant: 60),

            recaptureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            recaptureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            recaptureButton.widthAnchor.constraint(equalToConstant: 120),
            recaptureButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    // MARK: - Actions
    @objc private func acceptButtonPressed() {
        guard let image = image else { return }
        delegate?.didAccept(image: image)
        dismiss(animated: true, completion: nil)
    }

    @objc private func recaptureButtonPressed() {
        delegate?.didReject()
        dismiss(animated: true, completion: nil)
    }
}

