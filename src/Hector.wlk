import wollok.game.*


object hector {	
	var property position = game.at(5,9)
	var plantasParaVender = []
	var property cantOro = 0
	method image()= "player.png"
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
	method sembrar(especiePlanta){
		if(game.colliders(self).isEmpty()){
			especiePlanta.esPlantadaPor(self)
		}
	}
	
	method regar(){
		if(self.hayUnaPlantaEnPosicion()){
			var planta = game.colliders(self).find({cosa => cosa.esUnaPlanta()})
			planta.reaccionarSiEsRegada()
		}
		else{
			game.say(self, "no tengo nada para regar")
		}
		
	}
	
	method hayUnaPlantaEnPosicion(){
		return game.colliders(self).any({cosa => cosa.esUnaPlanta()})
	}
	
	method cosechar(){
		if(self.hayUnaPlantaEnPosicion()){
			var unaPlanta = game.colliders(self).first()
			self.cosecharSiDebo(unaPlanta)
		}
		else{
			game.say(self, "no tengo nada para cosechar")
		}
	}
	
	method cosecharSiDebo(planta){
		if(planta.estaListaParaCosecha()){
			game.removeVisual(planta)
			plantasParaVender.add(planta)
		}
	}
	
	method negociarConMercado(){
		if(self.hayUnMercadoEnPosicion()){
			var mercado = game.colliders(self).first()
			self.venderPlantasA(mercado)
		}
		else{
			game.say(self, "No estoy en un mercado")
		}
	}
	method venderPlantasA(unMercado){
		if(not plantasParaVender.isEmpty() and unMercado.puedeComprarleA(self)){
			plantasParaVender.forEach({unaPlanta => self.vender_A_(unaPlanta, unMercado)})
			game.say(self, "gracias por la compra")
		}
		
		else{game.say(self, "volvere en otro momento")}
	}
	
	method vender_A_(planta, mercado){
		mercado.comprar(planta)
		cantOro = cantOro + planta.precio()
		plantasParaVender.remove(planta)
		
	}
	
	method ingresosEstimadosPorVenta(){
		return plantasParaVender.sum({planta=> planta.precio()})
	}
	
	method darAConocerSituacionEconomica(){
		game.say(self, "tengo " + cantOro + " monedas, y "+ self.cantPlantasParaVender() + " plantas para vender")
	}
	
	method cantPlantasParaVender(){
		return plantasParaVender.size()
	}
	
	method hayUnMercadoEnPosicion(){
		return game.colliders(self).any({cosa => not cosa.esUnaPlanta()})
	}
}
