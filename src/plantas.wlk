import wollok.game.*


class Planta{
	var property position 
	var property esUnaPlanta = true
	var posicionActual
	method esPlantadaPor(persona){
		game.addVisualIn(self, persona.position())
		posicionActual = persona.position()
	}
	
	
}
class Tomaco inherits Planta{
	method image() = "tomaco.png"
	method reaccionarSiEsRegada(){
		game.removeVisual(self)
		self.trasladarse()
	}
	
	method trasladarse(){
		if(posicionActual.y() != 9){
			game.addVisualIn(self, posicionActual.up(1))
			posicionActual = posicionActual.up(1)
		}
		else{
			game.addVisualIn(self, game.at(posicionActual.x(),0))
			posicionActual= game.at(posicionActual.x(),0)
		}
		
	}
	
	method estaListaParaCosecha(){return true}
	
	method precio() = 80
	
}


class Maiz inherits Planta{
	var property image = "corn_baby.png"
	method crecer(nuevoAspecto){image = nuevoAspecto}
	method esAdulto(){
		return image == "corn_adult.png"
	}
	method reaccionarSiEsRegada(){
		if (not self.esAdulto()){
			self.crecer("corn_adult.png")
		}
	}
	method estaListaParaCosecha(){return self.esAdulto()}
	
	method precio()=150
	
}

class Trigo inherits Planta{
	var etapa = 0
	var property image = "wheat_" + etapa + ".png"
	method cambiarAspecto(){
		image = "wheat_" + etapa + ".png"
	}
	method reaccionarSiEsRegada(){
		self.evolucionarASiguienteEtapa()
	}

	method evolucionarASiguienteEtapa(){
		if(etapa == 3){
			etapa = 0
			self.cambiarAspecto()
		}
		else{
			etapa = etapa + 1
			self.cambiarAspecto()
		}
	}
	method estaListaParaCosecha(){
		return etapa >=2
	}
	
	method precio()= (etapa - 1) * 100
	
}
