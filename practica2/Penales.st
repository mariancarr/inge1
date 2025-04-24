!classDefinition: #PenalesTest category: #Penales!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test01DelanteroNoPuedeApuntarHaciaAfueraDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: -1@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test02DelanteroNoPuedeApuntarHaciaAfueraDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 3@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test03DelanteroNoPuedeApuntarHaciaAbajoDelArco
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@-1 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test04DelanteroNoPuedeApuntarHaciaArribaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@3 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test05ArqueroNoPuedePasarseDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: -1@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test06ArqueroNoPuedePasarseDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 3@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test07ArqueroNoPuedeMeterseAbajoDeLaTierra
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@-1.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test08ArqueroNoPuedeSaltarPorEncimaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@3.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test09DireccionesDiferentesGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante
	"varXXXX es por VAR, de 'Video Assistant Referee'"! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test10MismasDireccionesInsuficienteFuerzaGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 10.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test11MismasDireccionesSuficienteFuerzaAtajaArquero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test12DelanteroQueTiraAColocarPierde50PorcFuerza
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"(delantero sacrificia potencia para ganar mayor precisión)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test13ArqueroQueEligeAntesDeTiroVsJabulaniAColocarSuma50PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige donde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	"(el arquero llega más cómodo y aprovecha mejor su fuerza)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 34.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 51 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test14FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige adonde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 32.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 48 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test15ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAColocarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que espera y se adelanta ante un tiro de jabulani a colocar ignora la 2da coordenada (altura) al atajar..."	
	"(al adelanterse encara la pelota antes de que su elevación se transforme en un problema)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test16PelotaPlayeraUsadaAColocarLeHacePerder20PorcFuerzaExtraAlDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% de fuerza adicional al delantero que la use para colocar... (no importa el arquero)"
	"(no debería ser reglamentaria... al menos no es de trapo, nos responden)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test17ArqueroQueEligeAntesDeTiroVsPlayeraAColocarSuma100PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	"(a quien madruga...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 20.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test18FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsPlayeraAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 19.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 38 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test19ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAColocarEsDescubiertoYPuntoParaDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Arquero que espera y se adelanta ante tiro con la lenta pelota playera, siempre es descubierto por el Árbitro, y el punto se le otorga al Delantero..."
	"(lo que servía de ventaja ante la Jabulani rápida, acá es tan obvio por lo que tarda en llegar la pelota al arco, que marchás preso...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:52'!
test20DelanteroTiraAMatarAlAnguloInferiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:47'!
test21DelanteroTiraAMatarAlAnguloSuperiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:41'!
test22DelanteroTiraAMatarAlAnguloInferiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:36'!
test23DelanteroTiraAMatarAlAnguloSuperiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:29'!
test24DelanteroTiraAMatarNoAlAnguloMantieneDireccionTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@1.

	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test25DelanteroTiraAMatarUsa100PorcFuerzaBase
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:150.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 150 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test26DelanteroTiraAMatarConJabulaniGana20PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	"(Jabulani a matar es la elección de los guerreros Z)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 120.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test27FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAMatar
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 119.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test28ArqueroQueEligeAntesDeTiroVsJabulaniAMatarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que elige donde tirarse antes de un tiro de jabulani a matar, ignora la 2da coordenada (altura) al atajar..."		
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test29ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAMatarNuncaAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera a ver la dirección del remate de una pelota jabulani rápida a matar antes de lanzarse, nunca la ataja sin importar nada, siquiera que se adelantó..."	
	"(su poder era de más de 9000!! era impresionante, no podía moverme, sólo la ví pasar... f )"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@1 arqueroSeLanzaEnDirección: 1@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test30DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAdentro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(y voló.. y me hizo volar... y yo volé de él...  pero acá por la arbolada... y el voló.. y se estrelló por acá por la pared...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 1@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test31DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAfuera
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(El caso auspiciado por el Pipita...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@1 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@3 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test32ArqueroQueEligeAntesDeTiroVsPlayeraAMatarAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 18:39:22'!
test33ArqueroQueEligeAntesDeTiroVsPlayeraAMatarNoAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test34ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAMatarSiempreAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera y se adelanta ante una pelota playera lenta a matar, siempre la ataja sin importar nada..."	
	"(como la pelota es taaaan lentaaa, el arquero se puede ir a tomar un cafe, verse una serie, volver y aún atajar la pelota habiendose tirado a cualquier lado. Pero igual es más rapida que cuando se la tira a colocar, donde indefectiblemente el arbitro lo detecta...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !



!classDefinition: #Arquero category: #Penales!
Object subclass: #Arquero
	instanceVariableNames: 'fuerzaBase estiloAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Arquero methodsFor: 'caracteristicas' stamp: 'mc 4/22/2025 12:08:45'!
fuerza
	^fuerzaBase.! !


!Arquero methodsFor: 'initialize' stamp: 'mc 4/24/2025 10:36:26'!
initializeArquero: aTipoDeAtajada conFuerza: fuerzaBaseArquero.
	estiloAtajada := aTipoDeAtajada con: self.
	fuerzaBase := fuerzaBaseArquero.! !


!Arquero methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:36:41'!
recibeRemateAColocarConJabulaniEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales

	estiloAtajada recibeRemateAColocarConJabulaniEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales.! !

!Arquero methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:36:47'!
recibeRemateAColocarConPlayeraEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales

	estiloAtajada recibeRemateAColocarConPlayeraEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales.! !

!Arquero methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:36:55'!
recibeRemateAMatarConJabulaniEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales

	estiloAtajada recibeRemateAMatarConJabulaniEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales.! !

!Arquero methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:37:00'!
recibeRemateAMatarConPlayeraEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales

	estiloAtajada recibeRemateAMatarConPlayeraEnDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: #Penales!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 15:48:39'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: aFuerzaBaseArquero
	^(self new) initializeArquero: EligeDireccionAntesTiro conFuerza: aFuerzaBaseArquero. ! !

!Arquero class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 15:48:42'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: aFuerzaBaseArquero.
	^(self new) initializeArquero: EsperaTiroYSeAdelanta conFuerza: aFuerzaBaseArquero. ! !


!classDefinition: #Atajada category: #Penales!
Object subclass: #Atajada
	instanceVariableNames: 'arquero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Atajada methodsFor: 'initialize' stamp: 'mc 4/23/2025 18:13:32'!
initializeWith: anArquero

	arquero := anArquero ! !


!Atajada methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:38:47'!
recibeRemateAColocarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	
	self subclassResponsibility ! !

!Atajada methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:38:34'!
recibeRemateAColocarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	
	self subclassResponsibility ! !

!Atajada methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:38:08'!
recibeRemateAMatarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	self subclassResponsibility ! !

!Atajada methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:38:00'!
recibeRemateAMatarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	self subclassResponsibility ! !


!Atajada methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:34:15'!
arqueroIgnoraAlturaTiro

	^ [ :coordTiro :coordAtaj | coordTiro x = coordAtaj x]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Atajada class' category: #Penales!
Atajada class
	instanceVariableNames: ''!

!Atajada class methodsFor: 'as yet unclassified' stamp: 'mc 4/23/2025 15:48:07'!
con: anArquero
	^(self new) initializeWith: anArquero.! !


!classDefinition: #EligeDireccionAntesTiro category: #Penales!
Atajada subclass: #EligeDireccionAntesTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!EligeDireccionAntesTiro methodsFor: 'atajadas' stamp: 'mc 4/23/2025 17:24:45'!
recibeRemateAColocarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

	|fuerzaArquero |
	fuerzaArquero := arquero fuerza * 1.5.
	aPenales fuerzaResultanteArquero: fuerzaArquero.
	aPenales fuerzaResultanteTiro: aFuerzaTiro.
	! !

!EligeDireccionAntesTiro methodsFor: 'atajadas' stamp: 'mc 4/23/2025 17:24:57'!
recibeRemateAColocarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

	| fuerzaArquero |
	fuerzaArquero := arquero fuerza * 2.
	aPenales fuerzaResultanteArquero: fuerzaArquero.
	aPenales fuerzaResultanteTiro: aFuerzaTiro
		! !

!EligeDireccionAntesTiro methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:34:09'!
recibeRemateAMatarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	
	|arqueroEnCoordenadasCorrectas |
	arqueroEnCoordenadasCorrectas := self arqueroIgnoraAlturaTiro.
	
	aPenales fuerzaResultanteTiro: aFuerzaTiro.
	aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
	aPenales direccionDesviadaPorMatar: aDireccion.! !

!EligeDireccionAntesTiro methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:34:06'!
recibeRemateAMatarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales
	
	|arqueroEnCoordenadasCorrectas|
	arqueroEnCoordenadasCorrectas := self arqueroIgnoraAnchoTiro.
	
	aPenales fuerzaResultanteTiro: aFuerzaTiro.
	aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
	aPenales direccionDesviadaPorMatar: aDireccion.! !


!EligeDireccionAntesTiro methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:34:56'!
arqueroIgnoraAnchoTiro

	^ [ :coordTiro :coordAtaj | coordTiro y = coordAtaj y]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EligeDireccionAntesTiro class' category: #Penales!
EligeDireccionAntesTiro class
	instanceVariableNames: ''!

!EligeDireccionAntesTiro class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 12:22:44'!
con: anArquero
	^(self new) initializeWith: anArquero! !


!classDefinition: #EsperaTiroYSeAdelanta category: #Penales!
Atajada subclass: #EsperaTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:32:10'!
nuncaLeAlcanzaLaFuerza

	^ [:fuerzaRemate :fuerzaAtraparla | false]! !

!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:31:47'!
siempreEstaEnPosicionCorrecta

	^ [ :coordTiro :coordAtaj | true]! !

!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:35:33'!
siempreTieneFuerzaSuficiente

	^ [:fuerzaRemate :fuerzaAtraparla | true]! !


!EsperaTiroYSeAdelanta methodsFor: 'atajadas' stamp: 'mc 4/23/2025 17:42:55'!
recibeRemateAColocarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

	| arqueroEnCoordenadasCorrectas |
	arqueroEnCoordenadasCorrectas := self arqueroIgnoraAlturaTiro.
	
	aPenales fuerzaResultanteTiro: aFuerzaTiro.
	aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
	

		! !

!EsperaTiroYSeAdelanta methodsFor: 'atajadas' stamp: 'mc 4/23/2025 17:43:49'!
recibeRemateAColocarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

	| arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas |
	arqueroConFuerzaSuficiente := self nuncaLeAlcanzaLaFuerza.
	arqueroEnCoordenadasCorrectas := self siempreEstaEnPosicionCorrecta.
	
	aPenales fuerzaResultanteTiro: aFuerzaTiro.
	aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
	aPenales resuelvePenalConReglasDeFuerzaSuficente: arqueroConFuerzaSuficiente.
		
		! !

!EsperaTiroYSeAdelanta methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:32:42'!
recibeRemateAMatarConJabulaniEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

		|arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas| 
		arqueroConFuerzaSuficiente := self nuncaLeAlcanzaLaFuerza.
		arqueroEnCoordenadasCorrectas := self siempreEstaEnPosicionCorrecta.		
		aPenales fuerzaResultanteTiro: aFuerzaTiro.
		aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
		aPenales resuelvePenalConReglasDeFuerzaSuficente: arqueroConFuerzaSuficiente.
		aPenales direccionDesviadaPorMatar: aDireccion.! !

!EsperaTiroYSeAdelanta methodsFor: 'atajadas' stamp: 'mc 4/24/2025 10:32:52'!
recibeRemateAMatarConPlayeraEnDireccion: aDireccion conFuerza: aFuerzaTiro enPenales: aPenales

		|arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas|
		arqueroConFuerzaSuficiente := self siempreTieneFuerzaSuficiente.
		arqueroEnCoordenadasCorrectas := self siempreEstaEnPosicionCorrecta.
		
		aPenales fuerzaResultanteTiro: aFuerzaTiro.
		aPenales resuelvePenalConReglasDeCoordenadasCorrectas: arqueroEnCoordenadasCorrectas.
		aPenales resuelvePenalConReglasDeFuerzaSuficente: arqueroConFuerzaSuficiente.
		aPenales direccionDesviadaPorMatar: aDireccion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EsperaTiroYSeAdelanta class' category: #Penales!
EsperaTiroYSeAdelanta class
	instanceVariableNames: ''!

!EsperaTiroYSeAdelanta class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 12:22:53'!
con: anArquero
	^(self new) initializeWith: anArquero! !


!classDefinition: #Delantero category: #Penales!
Object subclass: #Delantero
	instanceVariableNames: 'fuerzaBase tipoDeTiro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Delantero methodsFor: 'initialize' stamp: 'mc 4/23/2025 12:21:55'!
initializeConTipoDeTiro: aTipoDeTiro conFuerza: aFuerzaBaseTiro
	tipoDeTiro := aTipoDeTiro con: self.
	fuerzaBase := aFuerzaBaseTiro.! !


!Delantero methodsFor: 'caracteristicas' stamp: 'mc 4/22/2025 11:05:17'!
fuerza
	^fuerzaBase.! !


!Delantero methodsFor: 'patearPenal' stamp: 'mc 4/23/2025 17:13:47'!
patea: pelota conDireccion: aDireccionRemate aArquero: arquero enPenales: aPenal
		
	tipoDeTiro remateEnDireccion: aDireccionRemate conPelota: pelota aArquero: arquero enPenales: aPenal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: #Penales!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 18:14:18'!
decideTirarAColocarSuFuerzaBaseEs: aFuerzaBaseTiro
	^(self new) initializeConTipoDeTiro: Colocar conFuerza: aFuerzaBaseTiro.! !

!Delantero class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 18:14:21'!
decideTirarAMatarSuFuerzaBaseEs: aFuerzaBase
	^(self new) initializeConTipoDeTiro: Matar conFuerza: aFuerzaBase.! !


!classDefinition: #Pelota category: #Penales!
Object subclass: #Pelota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Pelota methodsFor: 'as yet unclassified' stamp: 'mc 4/24/2025 10:41:16'!
remateAColocarAl: aArquero enDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales
	
	self subclassResponsibility ! !

!Pelota methodsFor: 'as yet unclassified' stamp: 'mc 4/24/2025 10:41:33'!
remateAMatarAl: aArquero conDireccionOriginal: aDireccionOriginal enDireccionDesviada: aDireccionDesviada conFuerza: aFuerza  enPenales: aPenales 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: #Penales!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 12:29:16'!
jabulaniSudafricanaRapida
	^Jabulani new! !

!Pelota class methodsFor: 'instance creation' stamp: 'mc 4/23/2025 12:29:25'!
playeraLentaCostaAzul
	^Playera new! !


!classDefinition: #Jabulani category: #Penales!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Jabulani methodsFor: 'as yet unclassified' stamp: 'mc 4/23/2025 16:17:25'!
remateAColocarAl: aArquero enDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales
	
	aArquero recibeRemateAColocarConJabulaniEnDireccion: aDireccion  conFuerza: aFuerza  enPenales: aPenales.
	! !

!Jabulani methodsFor: 'as yet unclassified' stamp: 'mc 4/24/2025 10:29:41'!
remateAMatarAl: aArquero conDireccionOriginal: aDireccionOriginal enDireccionDesviada: aDireccionDesviada conFuerza: aFuerza  enPenales: aPenales 

	|fuerzaTiroAMatar|
	fuerzaTiroAMatar := aFuerza * 1.2.
	aArquero recibeRemateAMatarConJabulaniEnDireccion: aDireccionDesviada  conFuerza: fuerzaTiroAMatar enPenales: aPenales.
	
	! !


!classDefinition: #Playera category: #Penales!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Playera methodsFor: 'desvio' stamp: 'mc 4/24/2025 10:42:49'!
desviar2ParaArriba: aDireccionOriginal

	^ aDireccionOriginal x @ (aDireccionOriginal y + 2)! !


!Playera methodsFor: 'penales' stamp: 'mc 4/24/2025 10:25:43'!
remateAColocarAl: aArquero enDireccion: aDireccion conFuerza: aFuerza enPenales: aPenales
	|fuerzaTiroColocarPlayera|
	fuerzaTiroColocarPlayera := aFuerza * 0.8.
	aArquero recibeRemateAColocarConPlayeraEnDireccion: aDireccion  conFuerza: fuerzaTiroColocarPlayera  enPenales: aPenales.
	! !

!Playera methodsFor: 'penales' stamp: 'mc 4/24/2025 10:42:49'!
remateAMatarAl: aArquero conDireccionOriginal: aDireccionOriginal enDireccionDesviada: aDireccionDesviada conFuerza: aFuerza  enPenales: aPenales 
	
	|direccionTiroDesvioPorMatarOPlayeraAMatar|
	direccionTiroDesvioPorMatarOPlayeraAMatar := aDireccionDesviada.
	(aPenales esUnAnguloDelArco: aDireccionOriginal) ifFalse:[direccionTiroDesvioPorMatarOPlayeraAMatar := self desviar2ParaArriba: aDireccionOriginal].
	aArquero recibeRemateAMatarConPlayeraEnDireccion: direccionTiroDesvioPorMatarOPlayeraAMatar conFuerza: aFuerza  enPenales: aPenales.
	! !


!classDefinition: #Penales category: #Penales!
Object subclass: #Penales
	instanceVariableNames: 'delantero arquero VARdireccionArquero VARdireccionTiro VARfuerzaTiro VARfuerzaArquero puntajeDeDelantero puntajeDelArquero arqueroEnCoordenadasCorrectas arqueroConFuerzaSuficiente'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Penales methodsFor: 'var' stamp: 'mc 4/24/2025 10:33:21'!
direccionDesviadaPorMatar: aDireccion
	VARdireccionTiro := aDireccion ! !

!Penales methodsFor: 'var' stamp: 'mc 4/23/2025 17:45:40'!
fuerzaResultanteArquero: fuerzaArquero
	VARfuerzaArquero := fuerzaArquero. ! !

!Penales methodsFor: 'var' stamp: 'mc 4/23/2025 17:45:06'!
fuerzaResultanteTiro: aFuerzaTiro
	VARfuerzaTiro := aFuerzaTiro.! !

!Penales methodsFor: 'var' stamp: 'mc 4/24/2025 10:18:07'!
varDireccionRemateResultante
	^VARdireccionTiro . ! !

!Penales methodsFor: 'var' stamp: 'mc 4/24/2025 10:18:14'!
varFuerzaResultanteDeAtajada
	^VARfuerzaArquero ! !

!Penales methodsFor: 'var' stamp: 'mc 4/24/2025 10:18:22'!
varFuerzaResultanteDeTiro
	^VARfuerzaTiro .! !


!Penales methodsFor: 'puntajes' stamp: 'mc 4/24/2025 10:48:51'!
atajoArquero
	
	self puntoParaArquero ! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/24/2025 10:49:01'!
erroDelantero
	
	self puntoParaArquero ! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/24/2025 10:49:10'!
golDelantero
	
	self puntoParaDelantero ! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/22/2025 10:29:18'!
puntajeDeArquero
	^puntajeDelArquero.! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/22/2025 10:28:54'!
puntajeDeDelantero
	^puntajeDeDelantero.! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/24/2025 10:49:22'!
puntoParaArquero

	 puntajeDelArquero := puntajeDelArquero +1! !

!Penales methodsFor: 'puntajes' stamp: 'mc 4/24/2025 10:49:19'!
puntoParaDelantero

	 puntajeDeDelantero := puntajeDeDelantero +1! !


!Penales methodsFor: 'initialize' stamp: 'mc 4/22/2025 10:27:36'!
initializeConDelantero: aDelantero yArquero: anArquero
	delantero:= aDelantero.
	arquero := anArquero.
	puntajeDeDelantero := 0.
	puntajeDelArquero := 0.! !


!Penales methodsFor: 'ganador' stamp: 'mc 4/24/2025 10:51:31'!
arqueroConFuerzaSuficiente

	^ arqueroConFuerzaSuficiente value: VARfuerzaTiro value: VARfuerzaArquero! !

!Penales methodsFor: 'ganador' stamp: 'mc 4/24/2025 10:52:14'!
arqueroEligeBienYLeAlcanzaLaFuerza 
	^(self arqueroEnMismaPosicionQueElTiro) and: [self arqueroConFuerzaSuficiente]! !

!Penales methodsFor: 'ganador' stamp: 'mc 4/24/2025 10:52:25'!
arqueroEnMismaPosicionQueElTiro
	^ arqueroEnCoordenadasCorrectas value: VARdireccionTiro value: VARdireccionArquero! !

!Penales methodsFor: 'ganador' stamp: 'mc 4/24/2025 10:20:05'!
remateVaAlArco
	^self direccionDentroDeArco: VARdireccionTiro. ! !

!Penales methodsFor: 'ganador' stamp: 'mc 4/24/2025 10:16:16'!
seDeterminaGanadorEnBaseAReglasYVAR
	^(self remateVaAlArco)
		ifFalse: [self erroDelantero]
		ifTrue: [(self arqueroEligeBienYLeAlcanzaLaFuerza )
			ifTrue:[self atajoArquero]
			ifFalse:[self golDelantero]
		]! !


!Penales methodsFor: 'jugarPenal' stamp: 'mc 4/23/2025 18:12:35'!
arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: aDireccionDelRemate arqueroSeLanzaEnDirección: aDireccionDelArquero
	
	self assertDireccionesValidasPortero: aDireccionDelArquero remate: aDireccionDelRemate. 
	
	self registrarValoresInicialesVARconDireccionTiro: aDireccionDelRemate yDireccionArquero: aDireccionDelArquero.
	self registrarReglasPrincipales.

	delantero patea: pelota conDireccion: aDireccionDelRemate aArquero: arquero enPenales: self.  

	self seDeterminaGanadorEnBaseAReglasYVAR.
	
													
				! !


!Penales methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:08:27'!
registrarReglasPrincipales

	arqueroEnCoordenadasCorrectas := [ :coordTiro :coordAtaj | coordTiro = coordAtaj].
	arqueroConFuerzaSuficiente := [:fuerzaRemate :fuerzaAtraparla | fuerzaRemate <= fuerzaAtraparla]! !

!Penales methodsFor: 'reglas' stamp: 'mc 4/24/2025 10:11:07'!
registrarValoresInicialesVARconDireccionTiro: aDireccionDelRemate yDireccionArquero: aDireccionDelArquero

	VARfuerzaTiro := delantero fuerza.
	VARfuerzaArquero := arquero  fuerza.
	VARdireccionArquero := aDireccionDelArquero.
	VARdireccionTiro := aDireccionDelRemate! !

!Penales methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:41:55'!
resuelvePenalConReglasDeCoordenadasCorrectas: reglasCoordenadasCorrectas.
	
	arqueroEnCoordenadasCorrectas := reglasCoordenadasCorrectas.! !

!Penales methodsFor: 'reglas' stamp: 'mc 4/23/2025 17:41:11'!
resuelvePenalConReglasDeFuerzaSuficente: reglasDeFuerza.
	
	arqueroConFuerzaSuficiente := reglasDeFuerza.! !


!Penales methodsFor: 'assert' stamp: 'mc 4/23/2025 11:09:24'!
assertDireccionValida: aDireccion sinoError: anErrorMessage

	(self direccionDentroDeArco: aDireccion) ifFalse: [self error: anErrorMessage ].! !

!Penales methodsFor: 'assert' stamp: 'mc 4/23/2025 11:08:33'!
assertDireccionesValidasPortero: aDireccionPortero remate: aDireccionRemate
	
	self assertDireccionValida: aDireccionPortero sinoError: Penales direccionArqueroFueraDeRango. 
	self assertDireccionValida: aDireccionRemate sinoError: Penales direccionTiroFueraDeRango . 
! !

!Penales methodsFor: 'assert' stamp: 'mc 4/23/2025 11:09:24'!
direccionDentroDeArco: aDireccion

	^ aDireccion between: 0@0 and: 2@2! !

!Penales methodsFor: 'assert' stamp: 'mc 4/24/2025 10:47:20'!
esUnAnguloDelArco: aDireccionTiro

	^(aDireccionTiro x = 0 or: [ aDireccionTiro x = 2]) and:[aDireccionTiro y = 0 or: [aDireccionTiro y = 2]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: #Penales!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:49'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:32'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !


!Penales class methodsFor: 'instance creation' stamp: 'mc 4/22/2025 10:09:21'!
conDelantero: aDelantero yArquero: anArquero
	^(self new) initializeConDelantero: aDelantero yArquero: anArquero.! !


!classDefinition: #RemateAlArco category: #Penales!
Object subclass: #RemateAlArco
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!RemateAlArco methodsFor: 'penales' stamp: 'mc 4/24/2025 10:43:44'!
remateEnDireccion: aDireccionTiro conPelota: aPelota aArquero: aArquero enPenales: aPenales
	
	self subclassResponsibility ! !


!RemateAlArco methodsFor: 'initialize' stamp: 'mc 4/23/2025 12:26:49'!
initializeWith: aDelantero.
	delantero := aDelantero.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RemateAlArco class' category: #Penales!
RemateAlArco class
	instanceVariableNames: 'delantero'!


!classDefinition: #Colocar category: #Penales!
RemateAlArco subclass: #Colocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Colocar methodsFor: 'penales' stamp: 'mc 4/24/2025 10:23:51'!
remateEnDireccion: aDireccionTiro conPelota: aPelota aArquero: aArquero enPenales: aPenales

	|fuerzaTiro|
	fuerzaTiro := (delantero fuerza *0.5). 
	aPelota remateAColocarAl: aArquero enDireccion: aDireccionTiro conFuerza: fuerzaTiro  enPenales: aPenales. 
		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Colocar class' category: #Penales!
Colocar class
	instanceVariableNames: ''!

!Colocar class methodsFor: 'as yet unclassified' stamp: 'mc 4/23/2025 12:20:00'!
con: aDelantero
	^(self new) initializeWith: aDelantero.! !


!classDefinition: #Matar category: #Penales!
RemateAlArco subclass: #Matar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Penales'!

!Matar methodsFor: 'penales' stamp: 'mc 4/23/2025 16:51:58'!
remateEnDireccion: aDireccionTiroOriginal conPelota: aPelota aArquero: aArquero enPenales: aPenales

	|fuerzaTiro direccionTiroDesviada|
	direccionTiroDesviada := aDireccionTiroOriginal.
	fuerzaTiro := delantero fuerza. 
	(aPenales esUnAnguloDelArco: aDireccionTiroOriginal ) ifTrue:[direccionTiroDesviada := aDireccionTiroOriginal x @ 1].
	aPelota remateAMatarAl: aArquero conDireccionOriginal: aDireccionTiroOriginal enDireccionDesviada: direccionTiroDesviada  conFuerza: fuerzaTiro enPenales: aPenales.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Matar class' category: #Penales!
Matar class
	instanceVariableNames: ''!

!Matar class methodsFor: 'as yet unclassified' stamp: 'mc 4/23/2025 12:20:08'!
con: aDelantero
	^(self new) initializeWith: aDelantero.! !
