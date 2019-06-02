class Mercado{
	var mercaderiasParaVender = []
	var property position
	var property cantMonedas
	method esUnaPlanta() = false
	method image() = "market.png"
	method puedeComprarleA(persona){
		return cantMonedas >= persona.ingresosEstimadosPorVenta()
	}
	
	method comprar(cosa){
		mercaderiasParaVender.add(cosa)
		cantMonedas = cantMonedas - cosa.precio()
	}
}