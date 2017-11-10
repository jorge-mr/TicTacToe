//
//  Gato.swift
//  TicTacToe
//
//  Created by Jorge MR on 22/06/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//

import UIKit

class Gato: UIViewController {

    @IBOutlet weak var ganadorLabel: UILabel!
    @IBOutlet weak var nuevoJuegoBoton: UIBarButtonItem!
    @IBOutlet weak var pausaBoton: UIBarButtonItem!
    @IBOutlet weak var nombreJugador1Label: UILabel!
    @IBOutlet weak var nombreJugador2Label: UILabel!
    @IBOutlet weak var avatarJugador1: UIButton!
    @IBOutlet weak var avatarJugador2: UIButton!
    
    var jugadorActivo : Int = 1
    //jugadorActivo : 1 circulos, 2 taches
    
    var estadoJuego = [0,0,0,0,0,0,0,0,0]
    // 0 (no hay imagen), 1(circulo), 2(taches)
    
    let combinacionesGanadoras = [
        //horizontales
        [0,1,2], [3,4,5], [6,7,8],
        //verticales
        [0,3,6], [1,4,7], [2,5,8],
        //ddiagonales
        [0,4,8], [2,4,6]
    ]
    
    var partidaActiva : Bool = true
    var contador : Int = 0
    
    //Informacion pasada desde el primer ViewController
    var nombreJugador1 = "Jugador 1"
    var nombreJugador2 = "Jugador 2"
    var iconoJugador1 : Int = 3
    var iconoJugador2 : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ganadorLabel.isHidden = true
        if nombreJugador1 != ""{
            nombreJugador1Label.text = nombreJugador1
        }
        if nombreJugador2 != "" {
            nombreJugador2Label.text = nombreJugador2
        }
        ganadorLabel.center = CGPoint(x: ganadorLabel.center.x - 500, y: ganadorLabel.center.y)
        avatarJugador1.center = CGPoint(x: avatarJugador1.center.x - 500, y: avatarJugador1.center.y)
        avatarJugador2.center = CGPoint(x: avatarJugador2.center.x + 500, y: avatarJugador2.center.y)
        avatarJugador1.setImage(UIImage(named: "user\(iconoJugador1)"),for: [])
        avatarJugador2.setImage(UIImage(named: "user\(iconoJugador2)"),for: [])
        UIView.animate(withDuration: 3){
            self.avatarJugador1.center = CGPoint(x: self.avatarJugador1.center.x + 500, y: self.avatarJugador1.center.y)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botonPrecionado(_ sender: UIButton) {
        let posActiva = sender.tag - 1
        
        if estadoJuego[posActiva] == 0 && partidaActiva {
            sender.alpha=0
            
            if jugadorActivo == 1{
                UIView.animate(withDuration: 0.5){
                    sender.alpha = 1
                    sender.setImage(UIImage(named: "circulo.png"),for: [])
                    //for: [] es para el estado por defecto del boton
                    self.contador += 1
                }
                jugadorActivo = 2
            }else{
                UIView.animate(withDuration: 0.5){
                    sender.alpha = 1
                    sender.setImage(UIImage(named: "tache.png"),for: [])
                    //for: [] es para el estado por defecto del boton
                    self.contador += 1
                }
                jugadorActivo = 1
            }
            estadoJuego[posActiva] = jugadorActivo
            
            for combinacion in combinacionesGanadoras{
                if estadoJuego[combinacion[0]] != 0 && estadoJuego[combinacion[0]] == estadoJuego[combinacion[1]] && estadoJuego[combinacion[1]] == estadoJuego[combinacion[2]] && estadoJuego[combinacion[0]] == estadoJuego[combinacion[2]] {
                    partidaActiva = false
                    
                    ganadorLabel.isHidden = false
                    //1 si ganan los circulos
                    if estadoJuego[combinacion[0]] == 1 {
                        ganadorLabel.text = "Ganó \(nombreJugador2Label.text!)"
                    }else{ //0 si ganan los taches
                        ganadorLabel.text = "Ganó \(nombreJugador1Label.text!)"
                    }
                    UIView.animate(withDuration: 1){
                        self.ganadorLabel.center = CGPoint(x: self.ganadorLabel.center.x + 500, y: self.ganadorLabel.center.y)
                        
                    }
                }else{
                    if contador >= 9{
                        ganadorLabel.isHidden = false
                        ganadorLabel.text = "Gato encerrado"
                        UIView.animate(withDuration: 1){
                            self.ganadorLabel.center = CGPoint(x: self.ganadorLabel.center.x + 500, y: self.ganadorLabel.center.y)
                        
                        }
                    }
                }
            }
        }else{
            print("partida inactiva")
        }
        print("Contador : \(contador)")
    }
    
    @IBAction func nuevoJuego(_ sender: UIBarButtonItem) {
        estadoJuego = [0,0,0,0,0,0,0,0,0]
        jugadorActivo = 1
        contador = 0
        partidaActiva = true
        for i in 1...9{
            if let button =  view.viewWithTag(i) as? UIButton{
                button.setImage(nil, for: [])
            }
        }
        ganadorLabel.isHidden = true
        
        ganadorLabel.center = CGPoint(x: ganadorLabel.center.x - 500, y: ganadorLabel.center.y)
    }
    
    @IBAction func pausa(_ sender: UIBarButtonItem) {
        partidaActiva = !partidaActiva
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
