//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jorge MR on 22/06/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldJugador1: UITextField!
    @IBOutlet weak var textFieldJugador2: UITextField!
    @IBOutlet weak var imageViewJugador1: UIButton!
    @IBOutlet weak var imageViewJugador2: UIButton!
    
    var nombreJugador1 : String?
    var nombreJugador2 : String?
    
    var user1 : Int = 3
    var user2 : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cambiaIconoJugador1(_ sender: UIButton) {
        
        user1+=1
        if user1 == 4{
            user1 = 1
        }else{}
        imageViewJugador1.setImage(UIImage(named: "user\(user1)"), for: [])
    }
    
    @IBAction func cambiaIconoJugador2(_ sender: UIButton) {
        user2+=1
        if user2 == 4{
            user2 = 1
        }else{}
        imageViewJugador2.setImage(UIImage(named: "user\(user2)"), for: [])
    }
    @IBAction func jugar(_ sender: UIButton) {
        performSegue(withIdentifier: "cambiaVista", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewControllerDestino = segue.destination as! Gato
        if textFieldJugador1.text != nil {
            viewControllerDestino.nombreJugador1 = textFieldJugador1.text!
            
        }
        if textFieldJugador2.text != nil {
            viewControllerDestino.nombreJugador2 = textFieldJugador2.text!
            
        }
        viewControllerDestino.iconoJugador1 = user1 //indice de jugador
        viewControllerDestino.iconoJugador2 = user2 //indice de jugador
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}

