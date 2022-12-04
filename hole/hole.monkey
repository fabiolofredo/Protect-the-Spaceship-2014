#rem

'#ADMOB_PUBLISHER_ID=""							'from your admod account
#ADMOB_ANDROID_TEST_DEVICE1=""
#ADMOB_ANDROID_TEST_DEVICE2=""	'your device's admob ID for test mode
#ADMOB_ANDROID_TEST_DEVICE3=""
#ADMOB_ANDROID_TEST_DEVICE4=""

#MOJO_HICOLOR_TEXTURES=True
#MOJO_IMAGE_FILTERING_ENABLED=True

#ANDROID_APP_LABEL="Protect the Spaceship"
#ANDROID_APP_PACKAGE="com.monkey.protectthespaceship"
#ANDROID_SCREEN_ORIENTATION="user"					'"user", "portrait", "landscape"
#ANDROID_GAMEPAD_ENABLED=False
#ANDROID_VERSION_CODE="2"
#ANDROID_VERSION_NAME="2.0"

#ANDROID_KEY_STORE=""
#ANDROID_KEY_ALIAS=""
#ANDROID_KEY_STORE_PASSWORD=""
#ANDROID_KEY_ALIAS_PASSWORD=""
#ANDROID_SIGN_APP=True

#OPENGL_GLES20_ENABLED=False

#ANDROID_NATIVE_GL_ENABLED=False

#TEXT_FILES="*.txt|*.xml|*.json"
#IMAGE_FILES="*.png|*.jpg|*.gif|*.bmp"
#SOUND_FILES="*.wav|*.ogg|*.mp3|*.m4a"
#MUSIC_FILES="*.wav|*.ogg|*.mp3|*.m4a"
#BINARY_FILES="*.bin|*.dat"
#rem
#end

#end



'#ADMOB_PUBLISHER_ID=""
    
'Import brl.admob
Import diddy
Import FacebookMonkey
'#ANDROID_APP_LABEL="Protect the Spaceship"
'#MOJO_IMAGE_FILTERING_ENABLED="false" 
Import mojo
Import fontmachine
#ANDROID_SCREEN_ORIENTATION="landscape"
'#GLFW_WINDOW_WIDTH=640/2
'#GLFW_WINDOW_HEIGHT=480/2
'#GLFW_WINDOW_WIDTH=640
'#GLFW_WINDOW_HEIGHT=480
'#GLFW_WINDOW_WIDTH=800
'#GLFW_WINDOW_HEIGHT=600
'#GLFW_WINDOW_WIDTH=1920
'#GLFW_WINDOW_HEIGHT=1080
Const WIDTH# = 640
Const HEIGHT# = 480
Global SCALE_RATIO_X#
Global SCALE_RATIO_Y#
Global TouchYscaled
Global TouchXscaled
Global Largura_Habilidades = 60
Global SIZEICON = 55
#rem 





#End

Global RAIO_NAVE = 10
Global RAIO_OBJETO = 12
Global RAIO_SOL = 20

Global channelhab = 10
Global channelexp = 1'1 a 9


Global Game_State:Float
Global Comprimento_Tela:Int = 640
Global Altura_Tela:Int =480

Class MyGame Extends App

	'Field admob:Admob
    'Field layout:=1
    Field enabled:=True

	Field channelexpcount:Int = 1
	Field Player1:Player = New Player()
	Field help:Image
	Field exp:Image
	Field rot:Image
	
	Field sun:Image
	Field fundo:Image
	Field planetas:Image 
	Field Rotfundo:Float
	Field CDclickOFF:Bool = False
	Field CDclicktimer:Int
	Field disco:Image
	Field IDobjeto:Int
	Field objetos:IntMap<objeto>= New IntMap<objeto>()
	Field objetotimer
	Field objetoCDoff:Bool = True
	'Field objrem:List<Int> = New List<Int>()
	Field objrem:IntMap<Int>= New IntMap<Int>()
	Field Score:Int
	Field Temp:Int
	
	Field timer:Int
	Field timer_temp:Int
	Field explosion:Sound
	Field DrawNewRecord:Bool = False
	Field number_ship:Int =0
	Field noRecord:Sound
	Field newRecord:Sound
	Field ah:Sound
	Field ohyeah:Sound
	Field font_bluesky:BitmapFont
	Field smallFont:BitmapFont
	Field sportsFont:BitmapFont
	Field ahh:Bool = True
	Field explosionMap:IntMap<Explosion> =  New IntMap<Explosion>()
	Field rotvelnumber:Int = 0
	Field FBshare:Bool = False
	Field habicon:Image
	Field explosionhab:Explosion = New Explosion()
	Field Clickhab:Bool = True
	Field ClickON:Bool = True
	Field explo_timer:Int
	Field laser:tiro[8]
	Field ball:spinballs[4]
	Field trail:trails[10]
	Field hab:habilidades[16]
	Field slot:Slots[32] 
	Field habONmouse:Int = -1
	Field habONmouseFORdesc:Int = -1
	Field drawONmouse:Bool = False
	Field deschabONmouse:Bool = false
	'Field ANDROID_SCREEN_ORIENTATION_option:String = "user"
	Field record$
	Field Record:Int 
	Field mouseONnavebool:Bool = False
	Field mouseONnaveint:Int = -1 
	'Field screen$
	'Field Screen:Int
	Field ship:Ships[13]
	Field fullhab:Bool = False
	Field totalscore:Int
	Field totalscoresave$
	Field gravar:String
	Field gravarsplit:String[] = New String[15]
	Field habsound:Sound
	
	Method OnCreate()
		
	
		
		'carregando o save
		gravar=LoadState()
		If gravar= "" 
			gravar = Int(0)+"-"+0
		End
		gravarsplit = gravar.Split("-")
		
		totalscore = Int(gravarsplit[0])
		Record = Int (gravarsplit[1])
		
	
		'Record = 1295
		'totalscore =  18934
	#rem
		screen=LoadState()
		If screen= "" 
			screen = 0
			Print("."+screen)
		End
		
		
	Select screen 
				Case 0
					#ANDROID_SCREEN_ORIENTATION="user"
					ANDROID_SCREEN_ORIENTATION_option = "user"
					Print(screen)
				Case 1
					#ANDROID_SCREEN_ORIENTATION="portrait"
					ANDROID_SCREEN_ORIENTATION_option = "portrait"
					Print(screen)
				Case 2 
					#ANDROID_SCREEN_ORIENTATION="landscape" 
					ANDROID_SCREEN_ORIENTATION_option = "landscape" 
					Print(screen)
			End
		
	#end
		#rem
		totalscoresave =LoadState()
		If totalscoresave = "" 
			totalscoresave = 0
		End
		totalscore = Int (totalscoresave)
		
		record =LoadState()
		If record = "" 
			record = 0
		End
		Record = Int (record)
		#end
			'FBSetUpApp("","Protect the Spaceship","")
		'FBSetUpApp("","Protect the Spaceship","")
		'FBSetUpApp("","Protect the Spaceship","")
		
		
		For Local i:Int = 0 Until 13
			ship[i] = New Ships(i)
		End
		
		
		For Local i:Int =0 Until 16
			hab[i] = New habilidades(i)
			hab[i].place = -1
		End
		For Local j:Int = 0 Until 8
			laser[j] = New tiro(j)
		End
		For Local j:Int = 0 Until 4
			ball[j] = New spinballs(j)
		End
		For Local j:Int = 0 Until 10
			trail[j] = New trails(j)
		End
		'admob=Admob.GetAdmob()
        'admob.ShowAdView 1,layout
        
        
		'criando a classe de slots de habilidades
		For Local i:Int =0 Until 32
			Local xhab:Int
			Local yhab:Int
			Local nomenu:Bool 
			Local j:Int
			If i<16
			
				nomenu = True
			Else
				nomenu = False
			
			End
			
			If nomenu = True
				j = i
				If i < 8
					xhab = Comprimento_Tela - 55
					yhab = i*60 + 2
				Else
					xhab = 0
					yhab = i*60+ 4 - (8*60 + 2)
				End
			Else
				j= i -16
				If i<20
				xhab = Largura_Habilidades +60 + 115*(i-16)
				yhab = 20
				Elseif i<24
				xhab = Largura_Habilidades + 60+ 115*(i-20)
				yhab = 120
				ElseIf i<28
				xhab = Largura_Habilidades+ 60 + 115*(i-24)
				yhab = 220
				Elseif i<32
				xhab = Largura_Habilidades + 60+ 115*(i-28)
				yhab = 320
				End
				
			End
			
		
			
			slot[i] = New Slots(j,xhab,xhab +SIZEICON ,yhab ,yhab +SIZEICON, nomenu)
		

		End
		
		
		
		
		SCALE_RATIO_X = DeviceWidth()/WIDTH
  		SCALE_RATIO_Y = DeviceHeight()/HEIGHT
		
		
		
	
		font_bluesky = New BitmapFont("bluesky/bluesky.txt", True)
		smallFont = New BitmapFont("basicsmallfont/basicsmallfont.txt", True)
		sportsFont = New BitmapFont("SportsFont/SportsFont.txt", True)
		Score = 0
		ah= LoadSound("ah.ogg")
		ohyeah= LoadSound("ohyeah.ogg")
		newRecord= LoadSound("newrecord.ogg")
		noRecord = LoadSound("norecord.ogg")
		explosion = LoadSound("explosion.ogg") 
		PlayMusic("music2.ogg", 1)
		habsound = LoadSound("hab.ogg") 
		
	
        habicon = LoadImage("habicon.png",55, 55,16 )
 		help = LoadImage("help.png",321, 147,1 ,Image.MidHandle)
		sun = LoadImage("sun.png",40, 40,1 ,Image.MidHandle)
		planetas = LoadImage("planetas.png",30, 30,52 ,Image.MidHandle)
		rot = LoadImage("rot.png",118, 93,1 ,Image.MidHandle)
		
		fundo = LoadImage("un.png",800 , 800,1 ,Image.MidHandle)
		disco = LoadImage("disco.png",31 , 31,22 ,Image.MidHandle)
		exp = LoadImage("exp0.png",30 , 30,32 ,Image.MidHandle)
		
		SetUpdateRate(60)
				
		explosionhab = New Explosion(exp,-300,-300)
	End
	
	Method OnUpdate()
	
	SCALE_RATIO_X = DeviceWidth()/WIDTH
  	SCALE_RATIO_Y = DeviceHeight()/HEIGHT
	TouchYscaled=TouchY/SCALE_RATIO_Y
	TouchXscaled=TouchX/SCALE_RATIO_X
		
		Select Game_State
		
			Case -2 'option
			
			#rem
			Select ANDROID_SCREEN_ORIENTATION_option
				Case "user"
					#ANDROID_SCREEN_ORIENTATION="user"
					If TouchHit And 100 <TouchXscaled And TouchXscaled < 200 And 200 > TouchYscaled And TouchYscaled > 100
						ANDROID_SCREEN_ORIENTATION_option = "portrait"
						screen = 1
						SaveState screen
						Print(screen)
					End
				Case "portrait"
					#ANDROID_SCREEN_ORIENTATION="portrait"
					If TouchHit And 100 <TouchXscaled And TouchXscaled < 200 And 200 > TouchYscaled And TouchYscaled > 100
						ANDROID_SCREEN_ORIENTATION_option = "landscape"
						screen = 2
						
						SaveState screen
						Print(screen)
					End
				Case "landscape"
					#ANDROID_SCREEN_ORIENTATION="landscape"  
					If TouchHit And 100 <TouchXscaled And TouchXscaled < 200 And 200 > TouchYscaled And TouchYscaled > 100
						ANDROID_SCREEN_ORIENTATION_option = "user"
						screen = 0
						
						SaveState screen
						Print(screen)
					End           
			End
			#end
		
			'SetMusicVolume =
			
			
			
			
			
			'eh o back
				If TouchHit And (400-120) <TouchXscaled And TouchXscaled < (500-120) And 350 > TouchYscaled And TouchYscaled > 300
					Game_State= 0
					'admob.ShowAdView 1,layout
				End
				
				
			Case -1 'tela do help
			
				'eh o back
				If TouchHit And (400-120) <TouchXscaled And TouchXscaled < (500-120) And 350 > TouchYscaled And TouchYscaled > 300
					Game_State= 0
					'admob.ShowAdView 1,layout
				End
			
			Case 0'tela inicial
 
		           
            	'atalho option
            	#rem
				If TouchHit And 276 >TouchXscaled And TouchXscaled > 164 And (350+60) > TouchYscaled And TouchYscaled > (300+60)
					Game_State= -2
					admob.HideAdView
					enabled=False
				End
			#end
				'atalho para o quit
				If TouchHit And 400 <TouchXscaled And TouchXscaled < 500 And (350+60) > TouchYscaled And TouchYscaled > (300+60)
					StopMusic()
					
					EndApp()
					'admob.HideAdView
					enabled=False
				End
				
				'atalho para o play
				If TouchHit And 276 >TouchXscaled And TouchXscaled > 164 And 350 > TouchYscaled And TouchYscaled > 300
					'admob.HideAdView
					
					Player1.Reset()
					objetos.Clear()
					Game_State= 0.8
					Seed = Millisecs()
					Score = 0
					CDclickOFF = False
					timer_temp = Millisecs()/1000
					timer = 0
					ClickON= True
				End
				'atalho para o help
				If TouchHit And 400 <TouchXscaled And TouchXscaled < 500 And 350 > TouchYscaled And TouchYscaled > 300
					Game_State= -1
				
				End
			Case 0.8'tela das naves
			'Record = 400
				
				'rotation para nave
				
				If TouchDown And 145 < TouchXscaled And TouchXscaled < 175 And 250 > TouchYscaled And TouchYscaled > 205
					Player1.Rot += -1
				End
				If TouchDown And 225 < TouchXscaled And TouchXscaled < 255 And 250 > TouchYscaled And TouchYscaled > 205
					Player1.Rot += 1
				End
				If TouchHit And 145 < TouchXscaled And TouchXscaled < 175 And 300 > TouchYscaled And TouchYscaled > 260
					If rotvelnumber > -10
						Player1.rotvel += -0.03
						rotvelnumber += -1
						
					Else
						PlaySound(noRecord)
					End
				End
				If TouchHit And 225 < TouchXscaled And TouchXscaled < 255 And 300 > TouchYscaled And TouchYscaled > 260
					If rotvelnumber < 10
						Player1.rotvel += 0.03
						rotvelnumber += 1
					Else
						PlaySound(noRecord)
					End
				End
				
				
				' touch das naves para comprar  6 primeiras naves e descrever
				For Local i:Int =0 Until 6
					Local xini:Int = 185
					Local yini:Int = 45
					Local ymax:Int = 90
					Local xmax:Int = 215
					
				
					If (xini+(i*50)) < TouchXscaled And TouchXscaled < (xmax+(i*50))And ymax> TouchYscaled And TouchYscaled > yini
						
						mouseONnavebool = True
						mouseONnaveint = i
						
						If TouchHit
					
							If Record >= i*15
								number_ship = i
								PlaySound(ohyeah)
							Else PlaySound(noRecord)
							End
						End
					End
				End
					
				For Local i:Int =6 Until 12
					Local xini:Int = 185
					Local yini:Int = 120
					Local ymax:Int = 160
					Local xmax:Int = 215
					' touch das naves para comprar  das 6 as 12 naves e descrever
					
					If (xini+((i-6)*50)) < TouchXscaled And TouchXscaled < (xmax+((i-6)*50)) And ymax > TouchYscaled And TouchYscaled > yini
						
						mouseONnavebool = True
						mouseONnaveint = i
						
						If TouchHit 
							If Record >= i*100-500
								number_ship = i
								PlaySound(ohyeah)
							Else PlaySound(noRecord)
							End
						End
					End
				End	
				' touch das naves para comprar a ultima nave e descrever
				If 435 < TouchXscaled And TouchXscaled < 465 And 260 > TouchYscaled And TouchYscaled > 220
					
					mouseONnavebool = True
					mouseONnaveint = 12
					
					If TouchHit 
					
						If Record >= 1000
							number_ship = 12
							PlaySound(ohyeah)
						Else PlaySound(noRecord)
						End
					End
				End
					
					
							
				
				
				'eh o start
				If TouchHit And 116+640/2-50 >TouchXscaled And TouchXscaled > 640/2-50 And 460 > TouchYscaled And TouchYscaled > 400
					Game_State= 0.9
					
				End
			Case 0.9 'tela de escolhas das habilidades
		
				'sÃ£o as escolhas das habilidades
				deschabONmouse = False
				habONmouseFORdesc = -1
				Local numeroescolhidohab:Int = 0
				
				For Local j:Int = 0 Until 16
					If hab[j].place <> -1	
					
						numeroescolhidohab+=1
						
					End
					If numeroescolhidohab < ship[number_ship].numberhab
						fullhab = False
					Else
						fullhab = True
					End
				End
				
				
				For Local i:Int = 0 Until 32
				
					'limitando as ships
					
				
					If TouchDown = 1 And slot[i].xmax >TouchXscaled And TouchXscaled > slot[i].xmin And slot[i].ymax > TouchYscaled And TouchYscaled > slot[i].ymin And fullhab = False
						If slot[i].nomenu = False And habONmouse = -1 ' escolha
							If totalscore >= hab[slot[i].index].price
								PlaySound(habsound,channelhab)
								habONmouse = slot[i].index
								drawONmouse = True
							Elseif TouchHit
								PlaySound(noRecord)
							End
						
						
						Elseif slot[i].nomenu = True'menu
						
							For Local j:Int = 0 Until 16'limpando as habilidades no place para colocar no menu
							
								If hab[j].place = slot[i].index And habONmouse <> -1 
									 
									hab[j].place = -1
									
								End
							End
						
							If habONmouse <> -1 'adicionando a habilidade no menu
								
								hab[habONmouse].place = slot[i].index
								drawONmouse = False
								habONmouse = -1
								PlaySound(habsound,channelhab)
						
							End
						
						
						End
					'se clicar no vaziu tirar o icone do mouse
					Elseif TouchHit Or TouchDown = 0
						
						drawONmouse = False
						habONmouse = -1
						
					End 
					'descriÃ§Ã£o das habilidades
					If TouchDown = 0 And slot[i].xmax >TouchXscaled And TouchXscaled > slot[i].xmin And slot[i].ymax > TouchYscaled And TouchYscaled > slot[i].ymin And drawONmouse = False
						
						If slot[i].nomenu = False' escolha
							deschabONmouse = True
							habONmouseFORdesc = slot[i].index
						
						Elseif slot[i].nomenu = True'menu
							Local teste:Bool = False
							
							For Local j:Int = 0 Until 16
							
								If hab[j].place = slot[i].index 
									deschabONmouse = True
									habONmouseFORdesc = j
									teste = True
								End
							End
							
							If teste = False
								deschabONmouse = False
								habONmouseFORdesc = -1
							
							End
								
								
						End
				
					End
					
					
					
					
					
				End
				
				'eh o reset
				If TouchHit And 116+640-220 >TouchXscaled And TouchXscaled > 640-220 And 460 > TouchYscaled And TouchYscaled > 400
				
					For Local j:Int = 0 Until 16
						hab[j].place = -1
					End
				End
				'eh o start
				If TouchHit And 116+640/2-50 >TouchXscaled And TouchXscaled > 640/2-50 And 460 > TouchYscaled And TouchYscaled > 400
					Game_State= 1
					
					StopMusic()
					Player1.Reset()
					objetos.Clear()
					Seed = Millisecs()
					Score = 0
					CDclickOFF = False
					timer_temp = Millisecs()/1000
					timer = 0
					ClickON= True
					drawONmouse = False
					habONmouse = -1
					deschabONmouse = False
					'admob.HideAdView
				End
				
			Case 1'rodando o jogo
			
				timer = Millisecs()/1000 - timer_temp 
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				'habilidades
				
				
				'locais das habilidades
				Local xhab:Int =0
				Local yhab:Int =0
				
					
				For Local i:Int =0 Until 16
					If i < 8
						xhab = Comprimento_Tela -55
						yhab = i*60 + 2
					Else
						xhab = 0
						yhab = i*60+ 4 - (8*60 + 2)
						
					End

					'clicando nas habilidades
					If TouchHit And xhab < TouchXscaled And TouchXscaled < xhab + 55 And yhab + 55 > TouchYscaled And TouchYscaled > yhab And Clickhab = True
					
					
			
						For Local j:Int = 0 Until 16
							If hab[j].place = i And hab[j].podeserativada = True
								hab[j].ativada= True
								hab[j].podeserativada = False
								PlaySound(habsound,channelhab)
							End
						End
					End
				End
				#rem
					Field timestart:Int
					Field timeCD:Int
					Field CD:Int
					Field duration:Int
				#end
				'ativaÃ§Ã£o das habilidades
				
				For Local i:Int=0 Until 16
					'resetando tudo na habilidade
					If hab[i].podeserativada = False And hab[i].ativada = False And hab[i].timeCD < Millisecs()
						hab[i].reset()
					End
					
					
					If hab[i].ativada = True
					
					
						Select hab[i].name
							Case "dot" '0
								
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].Update0()
									ClickON= False
									
								End
								If hab[i].Mode = 1 ' fica rodando, quando inicia
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].Update0()
									ClickON= False
									Clickhab = False
								End
								
								
								If hab[i].Mode = 2'  so 1 vez, quando clica 1Â° vez ou solta
									ClickON= True
									Clickhab = True
									hab[i].Mode +=1
									hab[i].drawCDdown = True
									
								End
								
								If hab[i].Mode >= 2  ' fica rodando, quando clica 1Â° ou mais vez ou solta
									
									'se o player atinge o habilidade
									If (Abs(Player1.Pos_x - hab[i].x)) < RAIO_NAVE + hab[i].raio And (Abs(Player1.Pos_y - hab[i].y)) < RAIO_NAVE + hab[i].raio
								
										Game_State = 2
									End
									'se os planetas atingem a habilidade
									For Local x:Int = Eachin objetos.Keys()
										
										If (Abs(hab[i].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[i].raio And (Abs(hab[i].y - (objetos.Get(x)).Pos_y)) < RAIO_OBJETO + hab[i].raio
											objrem.Add(x, x)
											Score +=1
										End
									End
								End
								If (TouchHit Or TouchDown = 0) And(TouchXscaled >Largura_Habilidades And TouchXscaled < Comprimento_Tela - Largura_Habilidades)
									hab[i].Mode +=1
								End
								
								
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 2
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
								
						
								
							Case "wall" '1
								
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].Update0()
									ClickON= False
									
								End
								If hab[i].Mode = 1 ' fica rodando, quando inicia
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].Update0()
									ClickON= False
									Clickhab = False
								End
								
								
								If hab[i].Mode = 2' so 1 vez, quando clica +1 vez ou solta
									ClickON= True
									Clickhab = True
									hab[i].Mode +=1
									hab[i].drawCDdown = True
								End
								
								If hab[i].Mode >= 2 ' fica rodando, quando clica 1Â° ou mais vez ou solta
									
									'se o player atinge o habilidade
									For Local j:Int = 0 Until 5	
										Local d1:Int 
										Local raio:Int = 10
										d1 = j*20
										If ((Abs(Player1.Pos_x - hab[i].x+d1*Cos(hab[i].floatextra))) < raio +RAIO_NAVE And (Abs(Player1.Pos_y - hab[i].y-d1*Sin(hab[i].floatextra))) <raio + RAIO_NAVE) Or
											((Abs(Player1.Pos_x - hab[i].x-d1*Cos(hab[i].floatextra))) < raio +RAIO_NAVE And (Abs(Player1.Pos_y - hab[i].y+d1*Sin(hab[i].floatextra))) <raio+RAIO_NAVE)
			
											Game_State = 2
										End
									
										'se os planetas atingem a habilidade
										For Local x:Int = Eachin objetos.Keys()
											If (Abs(objetos.Get(x).Pos_x - hab[i].x+d1*Cos(hab[i].floatextra)) < raio+RAIO_OBJETO And Abs(objetos.Get(x).Pos_y - hab[i].y-d1*Sin(hab[i].floatextra)) <raio+RAIO_OBJETO) Or
											(Abs(objetos.Get(x).Pos_x - hab[i].x-d1*Cos(hab[i].floatextra)) < raio +RAIO_OBJETO And Abs(objetos.Get(x).Pos_y - hab[i].y+d1*Sin(hab[i].floatextra)) <raio+RAIO_OBJETO)
												objrem.Add(x, x)
												Score +=1
											End
										End
									End
								End
								If (TouchHit Or TouchDown = 0) And(TouchXscaled >Largura_Habilidades And TouchXscaled < Comprimento_Tela - Largura_Habilidades)
									hab[i].Mode +=1
								End
								
								
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 2
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
								
							Case "shield" '2
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].Update2(Player1.Pos_x,Player1.Pos_y)
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									hab[i].Update2(Player1.Pos_x,Player1.Pos_y)
									For Local x:Int = Eachin objetos.Keys()
										
										If (Abs(hab[i].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[i].raio And (Abs(hab[i].y - (objetos.Get(x)).Pos_y)) < RAIO_OBJETO + hab[i].raio
											objrem.Add(x, x)
											Score +=1
											hab[i].timestart = 0
										End
									End
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
							Case "localization" '3
							
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
								
									
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
							
							
							
							Case "explosion" '4
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
								hab[i].podeserativada = False
								hab[i].DrawON = True
								hab[i].Update0()
								ClickON= False
								explosionhab.x = hab[i].x
								explosionhab.y = hab[i].y
									
								End
								If hab[i].Mode = 1 ' fica rodando, quando inicia
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].Update0()
									ClickON= False
									Clickhab = False
									explosionhab.x = hab[i].x
									explosionhab.y = hab[i].y
								End
								
								
								If hab[i].Mode = 2' so 1 vez, quando clica 1Â° vez ou solta
									ClickON= True
									Clickhab = True
									hab[i].Mode +=1
									hab[i].drawCDdown = True
									explosionhab.x = hab[i].x
									explosionhab.y = hab[i].y
									hab[i].boolextra = False
								End
								
								If hab[i].Mode >= 2 ' fica rodando, quando clica 1Â° ou mais vez ou solta
									
									'se o player atinge o habilidade
									If (Abs(Player1.Pos_x - hab[i].x)) < RAIO_NAVE + hab[i].raio And (Abs(Player1.Pos_y - hab[i].y)) < RAIO_NAVE + hab[i].raio
								
										Game_State = 2
									End
									'se os planetas atingem a habilidade
									For Local x:Int = Eachin objetos.Keys()
										
										If (Abs(hab[i].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[i].raio And (Abs(hab[i].y - (objetos.Get(x)).Pos_y)) < RAIO_OBJETO + hab[i].raio
											objrem.Add(x, x)
											Score +=1
										End
									End
								End
								If (TouchHit Or TouchDown = 0) And(TouchXscaled >Largura_Habilidades And TouchXscaled < Comprimento_Tela - Largura_Habilidades)
									hab[i].Mode +=1
								End
								
								
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 2
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
								
						
							Case "gravityoff" '5
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									hab[i].Update2(Player1.Pos_x,Player1.Pos_y)
									
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
							Case "teleport" '6
							
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									ClickON= False
									
								End
								If hab[i].Mode = 1 ' fica rodando, quando inicia
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].Update0()
									ClickON= False
									Clickhab = False
								End
								
								
								If hab[i].Mode = 2' so 1 vez, quando clica 1Â° vez 
									ClickON= True
									Clickhab = True
									Player1.Pos_x = TouchXscaled
									Player1.Pos_y = TouchYscaled
									Player1.Vel_x /= 2
									Player1.Vel_y /= 2
									hab[i].Mode +=1
									hab[i].drawCDdown = True
									hab[i].boolextra = False
									
								End
								
								
								If (TouchHit Or TouchDown = 0) And(TouchXscaled >Largura_Habilidades And TouchXscaled < Comprimento_Tela - Largura_Habilidades)
									hab[i].Mode +=1
								End
								
								
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 2
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
							Case "laser" '7
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									For Local j:Int = 0 Until 8
										laser[j].Update1(Player1.Pos_x,Player1.Pos_y,Player1.Vel_y,Player1.Vel_y)
									End
								
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									For Local j:Int = 0 Until 8
										laser[j].Update2()
										For Local x:Int = Eachin objetos.Keys()
											
											If (Abs(laser[j].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[i].raio And (Abs(laser[j].y - (objetos.Get(x)).Pos_y)) <RAIO_OBJETO + hab[i].raio
												objrem.Add(x, x)
												Score +=1
											End
										End									
									End									
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1 
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
									For Local j:Int = 0 Until 8
										laser[j].Reset()
									End
								End
							Case "missil" '8
								
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].Update8_0(Player1.Pos_x,Player1.Pos_y)
									hab[i].boolextra = True
									hab[i].drawCDdown = True
									Local dmintemp:Float = 0
									Local dmin:Float =10000000
									hab[i].intextra = 0
									For Local x:Int = Eachin objetos.Keys()
									
										
										dmintemp=Sqrt(Pow(hab[i].x-objetos.Get(x).Pos_x,2) + Pow(hab[i].y-objetos.Get(x).Pos_y,2))
									
										If dmintemp < dmin
										 
											dmin = dmintemp 
											
											hab[i].intextra = x
											
										End
										
									End
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									
									If hab[i].boolextra = True And objetos.Get(hab[i].intextra) <> Null And objetos.Get(hab[i].intextra) <> Null
									
										hab[i].Update8_1(objetos.Get(hab[i].intextra).Pos_x,objetos.Get(hab[i].intextra).Pos_y)
									Elseif hab[i].boolextra = False Or (objetos.Get(hab[i].intextra) = Null And objetos.Get(hab[i].intextra) = Null)
										hab[i].Update8_1(1,1)
									End
									
									For Local x:Int = Eachin objetos.Keys()
										If (Abs(hab[i].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[i].raio And (Abs(hab[i].y - (objetos.Get(x)).Pos_y)) <RAIO_OBJETO + hab[i].raio
											objrem.Add(x, x)
											Score +=1
											hab[i].timestart = 0
										End
									End
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
								
								
								
							Case "destroyenemyscreen" '9
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].intextra = 150
									hab[i].boolextra = True
									hab[i].drawCDdown = True
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									hab[i].Update2(Player1.Pos_x,Player1.Pos_y)
									For Local x:Int = Eachin objetos.Keys()
										If objetos.Get(x).Pos_x > Largura_Habilidades-30 And objetos.Get(x).Pos_x < (Comprimento_Tela-Largura_Habilidades+30) And objetos.Get(x).Pos_y > -30 And objetos.Get(x).Pos_y < (Altura_Tela +30)
									
											objrem.Add(x, x)
											Score +=1
										End
									End
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
							
								End
							Case "spinballs" '10
								If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									For Local j:Int = 0 Until 4
										ball[j].Update(Player1.Pos_x,Player1.Pos_y)
								
									
								
										For Local x:Int = Eachin objetos.Keys()
											
											If Abs(ball[j].x - objetos.Get(x).Pos_x) < RAIO_OBJETO + hab[i].raio And Abs(ball[j].y - objetos.Get(x).Pos_y) <RAIO_OBJETO + hab[i].raio
												objrem.Add(x, x)
												Score +=1
												
											End
										End
									End 
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
									For Local j:Int = 0 Until 4
										ball[j].Reset()
									End
								End
							Case "web" '11
							
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
								hab[i].podeserativada = False
								hab[i].DrawON = True
								hab[i].Update0()
								ClickON= False
								
								
							End
							If hab[i].Mode = 1 ' fica rodando, quando inicia
								hab[i].timeCD = Millisecs() + hab[i].CD
								hab[i].timestart = Millisecs()
								hab[i].Update0()
								ClickON= False
								Clickhab = False
							End
							
							
							If hab[i].Mode = 2' so 1 vez, quando clica 1Â° vez ou solta
								ClickON= True
								Clickhab = True
								hab[i].Mode +=1
								hab[i].boolextra = False
								hab[i].drawCDdown = True
							End
							
							If hab[i].Mode >= 2 ' fica rodando, quando clica 1Â° ou mais vez ou solta
							
								
								'se os planetas atingem a habilidade
								
							End
							If (TouchHit Or TouchDown = 0) And(TouchXscaled >Largura_Habilidades And TouchXscaled < Comprimento_Tela - Largura_Habilidades)
								hab[i].Mode +=1
							End
							
							
							If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 2
								hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
								hab[i].boolextra = True
							End
							
						
						
							Case "trail"'12
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
									hab[i].podeserativada = False
									hab[i].DrawON = True
									hab[i].timeCD = Millisecs() + hab[i].CD
									hab[i].timestart = Millisecs()
									hab[i].drawCDdown = True
									
								End
								If hab[i].Mode >= 1 ' fica rodando sempre
									For Local j:Int = 0 Until 10
										trail[j].Update(Player1.Pos_x,Player1.Pos_y, hab[i].timestart)
								
										For Local x:Int = Eachin objetos.Keys()
											
											If Abs(trail[j].x - objetos.Get(x).Pos_x) < RAIO_OBJETO + hab[i].raio And Abs(trail[j].y - objetos.Get(x).Pos_y) <RAIO_OBJETO + hab[i].raio And trail[j].first = False
												objrem.Add(x, x)
												Score +=1
												
											End
										End
									End 
								End
								
								
								If TouchHit
									hab[i].Mode +=1
								End
								If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
									hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
									For Local j:Int = 0 Until 10
										trail[j].Reset()
									End
								End
							
							Case "stop" '13
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
								hab[i].podeserativada = False
								hab[i].DrawON = True
								hab[i].timeCD = Millisecs() + hab[i].CD
								hab[i].timestart = Millisecs()
								hab[i].drawCDdown = True
								
							End
							If hab[i].Mode >= 1 ' fica rodando sempre
							
								For Local x:Int = Eachin objetos.Keys()
									objetos.Get(x).Rot = 0
									objetos.Get(x).Vel_x = 0
									objetos.Get(x).Vel_y = 0
								End
							End
							
							
							If TouchHit
								hab[i].Mode +=1
							End
							If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
								hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
						
							End
							Case "small"'14 
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
								hab[i].podeserativada = False
								hab[i].DrawON = True
								hab[i].timeCD = Millisecs() + hab[i].CD
								hab[i].timestart = Millisecs()
								hab[i].floatextra = 0.2
								hab[i].drawCDdown = True
							End
							If hab[i].Mode >= 1 ' fica rodando sempre
							RAIO_NAVE *= hab[i].floatextra
							
							End
							
							
							If TouchHit
								hab[i].Mode +=1
							End
							If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
								hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
								RAIO_NAVE = 10
							End
							Case "megawall" '15
							If hab[i].Mode = 0 ' so 1 vez, quando inicia
								hab[i].podeserativada = False
								hab[i].DrawON = True
								hab[i].timeCD = Millisecs() + hab[i].CD
								hab[i].timestart = Millisecs()
								hab[i].Update15
								hab[i].drawCDdown = True
							End
							If hab[i].Mode >= 1 ' fica rodando sempre
								
								Select hab[i].intextra
									Case 0 'up
									
										If Player1.Pos_x > hab[i].x  And Player1.Pos_x <hab[i].x + Comprimento_Tela - 2*Largura_Habilidades And Player1.Pos_y > hab[i].y - hab[i].raio - RAIO_NAVE  And Player1.Pos_y < hab[i].y + hab[i].raio + RAIO_NAVE
											Game_State = 2
										End
										For Local x:Int = Eachin objetos.Keys()
											If objetos.Get(x).Pos_x > hab[i].x  And objetos.Get(x).Pos_x <hab[i].x + Comprimento_Tela - 2*Largura_Habilidades And objetos.Get(x).Pos_y > hab[i].y - hab[i].raio - RAIO_OBJETO  And objetos.Get(x).Pos_y < hab[i].y + hab[i].raio + RAIO_OBJETO
												objrem.Add(x, x)
												Score +=1
											End
										End
									
									Case 1 'right
										If Player1.Pos_x > hab[i].x - hab[i].raio - RAIO_NAVE And Player1.Pos_x < hab[i].x + hab[i].raio + RAIO_NAVE And Player1.Pos_y > 0  And Player1.Pos_y < Altura_Tela
											Game_State = 2
						
										End
										For Local x:Int = Eachin objetos.Keys()
											If objetos.Get(x).Pos_x > hab[i].x - hab[i].raio - RAIO_OBJETO And objetos.Get(x).Pos_x < hab[i].x + hab[i].raio + RAIO_OBJETO And objetos.Get(x).Pos_y > 0  And objetos.Get(x).Pos_y < Altura_Tela
												objrem.Add(x, x)
													Score +=1
							
											End
										End
									Case 2'down
										If Player1.Pos_x > hab[i].x  And Player1.Pos_x <hab[i].x + Comprimento_Tela - 2*Largura_Habilidades And Player1.Pos_y > hab[i].y - hab[i].raio - RAIO_NAVE  And Player1.Pos_y < hab[i].y + hab[i].raio + RAIO_NAVE
											Game_State = 2
						
										End
										For Local x:Int = Eachin objetos.Keys()
											If objetos.Get(x).Pos_x > hab[i].x  And objetos.Get(x).Pos_x <hab[i].x + Comprimento_Tela - 2*Largura_Habilidades And objetos.Get(x).Pos_y > hab[i].y - hab[i].raio - RAIO_OBJETO  And objetos.Get(x).Pos_y < hab[i].y + hab[i].raio + RAIO_OBJETO
												objrem.Add(x, x)
												Score +=1
											End
										End
									Case 3'left
										If Player1.Pos_x > hab[i].x - hab[i].raio - RAIO_NAVE And Player1.Pos_x < hab[i].x + hab[i].raio + RAIO_NAVE And Player1.Pos_y > 0  And Player1.Pos_y < Altura_Tela
											Game_State = 2
						
										End
										For Local x:Int = Eachin objetos.Keys()
											If objetos.Get(x).Pos_x > hab[i].x - hab[i].raio - RAIO_OBJETO And objetos.Get(x).Pos_x < hab[i].x + hab[i].raio + RAIO_OBJETO And objetos.Get(x).Pos_y > 0  And objetos.Get(x).Pos_y < Altura_Tela
												objrem.Add(x, x)
													Score +=1
							
											End
										End
								End
									
									
							End
							
							
							If TouchHit
								hab[i].Mode +=1
							End
							If hab[i].timestart + hab[i].duration < Millisecs() And hab[i].Mode >= 1
								hab[i].reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
						
							End
						End
					End
				End
			
				
				
				
				
				'desativando o click no menu para o movimento
				If TouchHit And (Comprimento_Tela-Largura_Habilidades < TouchXscaled Or TouchXscaled < Largura_Habilidades)
					ClickON= False
				End
			
				
				
				
				'click para a nave movimentar
				
				If TouchHit = 1  And ClickON= True
					If CDclickOFF = True
						Player1.Touch()
						CDclickOFF = False
						CDclicktimer = Millisecs() + ship[number_ship].CDmove
					Else
						PlaySound(noRecord, channelhab)
						
					
					End
				End
				ClickON= True
				'CD para a nave movimentar
				If CDclickOFF = False And CDclicktimer < Millisecs()
					CDclickOFF = True
				End
				
				'calculando se a nave sair fora da tela
				If Player1.Pos_x < Largura_Habilidades-30 Or Player1.Pos_x > (Comprimento_Tela-Largura_Habilidades+30) Or Player1.Pos_y < -30 Or Player1.Pos_y > (Altura_Tela +30)
					Game_State = 2
				
				End
				
				'upgrade do movimento da nave
				'se o player atinge o habilidade
				If (Abs(Player1.Pos_x - hab[11].x)) < RAIO_NAVE + hab[11].raio And (Abs(Player1.Pos_y - hab[11].y)) <RAIO_NAVE + hab[11].raio And hab[11].boolextra = False
					Player1.Gravidade(hab[5].ativada,False)
				Else
					Player1.Gravidade(hab[5].ativada,True)
					
			 	End
			 	
				'CD para criar outro planeta
				If objetoCDoff = False And objetotimer < Millisecs()
					objetoCDoff = True
				End
				
			 	'criando outro planeta
			 	If objetoCDoff = True
			 
					objetos.Add(IDobjeto,New objeto())
					(objetos.Get(IDobjeto)).img = planetas
					IDobjeto +=1
					objetoCDoff = False
					objetotimer = Millisecs() + 1000
				
				End
			 	
			 	#rem
			
			 	'criando planetas teste temporario!!!!!!!!
			 	
			 	If objetoCDoff = False 
					objetos.Add(IDobjeto,New objeto())
					(objetos.Get(IDobjeto)).img = planetas
					IDobjeto +=1
				End
				
				#end
			 	
			 	
			 	'destruindo os planetas q forem no sol
			 	For Local x:Int = Eachin objetos.Keys()
				
					'movimento dos planetas		
					If (Abs(hab[11].x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + hab[11].raio And (Abs(hab[11].y - (objetos.Get(x)).Pos_y)) <RAIO_OBJETO + hab[11].raio And hab[11].boolextra = False
							(objetos.Get(x)).Gravidade(False)		
					Else
							(objetos.Get(x)).Gravidade(True)	
					End
					
					If objetos.Get(x).destruir = 1
						objrem.Add(x, x)
						Score +=1
						
					
					End
				End
				
		
			
				For Local x:Int = Eachin objetos.Keys()
				
					'calculando se um planeta colide com outro planeta
					For Local y:Int = Eachin objetos.Keys()
						If (Abs((objetos.Get(y)).Pos_x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO*2 And (Abs((objetos.Get(y)).Pos_y - (objetos.Get(x)).Pos_y)) <RAIO_OBJETO*2 And y > x
							objrem.Add(x, x)
							objrem.Add(y, y)
							Score += 2
							'Print(objetos.Count+" "+Temp)
						End
					
					End
					'calculando se a nave colide com outro planeta
					If (Abs(Player1.Pos_x - (objetos.Get(x)).Pos_x)) < RAIO_OBJETO + RAIO_NAVE And (Abs(Player1.Pos_y - (objetos.Get(x)).Pos_y)) <RAIO_OBJETO + RAIO_NAVE
						
						If hab[2].ativada = False
							Game_State = 2
						End
						PlaySound(explosion,channelexpcount)
						
						
					End
				End
				
				'removendo planetas que colidem um ao outro
				
				For Local x:Int = Eachin objrem.Keys()
					
					explosionMap.Add(x,New  Explosion(exp,(objetos.Get(x)).Pos_x,(objetos.Get(x)).Pos_y) )
					objetos.Remove(x)
					objrem.Remove(x)
					PlaySound(explosion,channelexpcount)
					If x = hab[8].intextra
						hab[8].boolextra = False
					End
			
				End
				
				
				'removendo explosoes
				For Local x:Int =  Eachin explosionMap.Keys()
					
					If explosionMap.Get(x).destruir=True 
					
						explosionMap.Remove(x)
					End
				
				End
				'atualizando os canais de sons para as explosoes
				channelexpcount +=1
				If channelexpcount = 10
					channelexpcount = 1
				End
				
				If Game_State = 2
					PlaySound(explosion)
					PlayMusic("music2.ogg", 1)
					
					For Local i = 0 Until 16
						hab[i].reset()
					End
					For Local j:Int = 0 Until 8
						laser[j].Reset()
					End
					For Local j:Int = 0 Until 4
						ball[j].Reset()
					End
					For Local j:Int = 0 Until 10
						trail[j].Reset()
					End
					ClickON= True
					Clickhab = True
					RAIO_NAVE = 10
            		'admob.ShowAdView 1,layout
            		channelexpcount = 1
				End
				
			Case 2 'tela final do jogo
		
		        ' record
				If Record < Score And ahh=True
					If Score > 999999999
						Score =  999999999
					End
					
					Record = Score
					
					record = String(Record)
					'SaveState record 
					DrawNewRecord = True
					PlaySound(newRecord)
					ahh= False
					FBshare = True
				
					totalscore += Score
					
					If totalscore > 999999999
						totalscore =  999999999
					End
					totalscoresave = String(totalscore)
					'SaveState totalscoresave
					
					gravar = String(totalscore)+"-"+String(Record)
					SaveState gravar
				
				Else
					
					If ahh=True
						PlaySound(ah)
						
						totalscore += Score
						If totalscore > 999999999
							totalscore =  999999999
						End
						
						totalscoresave = String(totalscore)
						'SaveState totalscoresave
						gravar = String(totalscore)+"-"+String(Record)
						SaveState gravar
					
					End
					ahh= False
					
					
				End
				
				
				'share no facebook
				
				If FBshare = True 
					If TouchHit And 20 < TouchXscaled And TouchXscaled < 620 And 420 > TouchYscaled And TouchYscaled > 380
				
						'FBWallPost("NEW RECORD!!!","The new record is "+Record+", Congratulations!!!",True)
						'FBLike()
					End
				End
				
				
				
				'atalho para o menu do jogo
				
				If TouchHit And 400 < TouchXscaled And TouchXscaled < 510 And 350 > TouchYscaled And TouchYscaled > 300
				
					Game_State= 0
					DrawNewRecord = False
					ahh=True
					'admob.ShowAdView 1,layout
					FBshare = False
				End
			
			
				'atalho para jogar de novo
				If TouchHit And 270 >TouchXscaled And TouchXscaled > 164 And 350 > TouchYscaled And TouchYscaled > 300
					StopMusic()
					Player1.Reset()
					objetos.Clear()
					Game_State= 1
					Seed = Millisecs()
					Score = 0
					CDclickOFF = False
					timer_temp = Millisecs()/1000
					timer = 0
					DrawNewRecord = False
					ahh=True
					'admob.HideAdView
					enabled=False
					FBshare = False
					ClickON= True
					channelexpcount = 1
				End
				
			End
			
	
	End
	
	Method OnRender()
	
	PushMatrix()
	Scale SCALE_RATIO_X, SCALE_RATIO_Y	
		
		PushMatrix()
		
		Translate(Comprimento_Tela/2, Altura_Tela/2)
		Rotfundo +=0.01
	
		Rotate(Rotfundo)
		DrawImage(fundo,0,0)
		PopMatrix()
		
		Select Game_State
			Case -2 'option
				'If TouchHit And 100 <TouchXscaled And TouchXscaled < 200 And 200 > TouchYscaled And TouchYscaled > 100
				
				'sportsFont.DrawText("Screen "+ ANDROID_SCREEN_ORIENTATION_option ,100,100)
				
				sportsFont.DrawText("Back",400-120,300)
			Case -1 ' tela do help
				
				
				
				SetColor(60,60,100)
				DrawRect(50, 50,550,400)
				SetColor(255,255,255)
				DrawImage(help,Comprimento_Tela/2, Altura_Tela/2-20 )
				sportsFont.DrawText("Back",400-120,300)
				SetColor(60,60,230)
				smallFont.DrawText("You lose when: 1)Collides with another planet. 2)Collides with the sun 3)Go out of screen ",50, 50)
				SetColor(200,200,0)
				smallFont.DrawText("You gain 1 point for each planet destroyed.",50, 75)
				SetColor(0,200,0)
				smallFont.DrawText("Further you touch, faster you go ",50, 100)
				
				SetColor(100,100,200)
				smallFont.DrawText("This game was created by Fabio Lofredo Cesar and thanks to Carina Dorissotti ",Comprimento_Tela/2-230, Altura_Tela - 50)
			
				SetColor(255,255,255)
				
			Case 0'tela inical
		
				font_bluesky.DrawText("Protect the Spaceship",100,50)
			
				
				'sportsFont.DrawText("Option",160,300+60)
				sportsFont.DrawText("Start",160,300)
				sportsFont.DrawText("Help",400,300)
				sportsFont.DrawText("Quit",400,300+60)
				
				PushMatrix()
					SetColor(255,50,50)
					Translate(260,180)
					Scale(1.5,1.5)
					smallFont.DrawText("Record: "+Record,0,0)
					SetColor(255,255,0)
					smallFont.DrawText("Total Score: "+totalscore,-15,15)
					
					SetColor(255,255,255)
				PopMatrix()
			Case 0.8' tela das naves
			
			'desenhando a sua nave , o desenho para rotacionar e a vel de rotaÃ§Ã£o
			
			Player1.Pos_x=200
			Player1.Pos_y=250
			Player1.Draw_Player(disco,number_ship,1,hab[6].boolextra)
			DrawImage(rot,Player1.Pos_x, Player1.Pos_y )
			smallFont.DrawText("Your Ship",Player1.Pos_x-30,Player1.Pos_y-30)
			smallFont.DrawText("Rot:"+rotvelnumber,Player1.Pos_x-15,Player1.Pos_y+15)
			
		
			
			
				
				'as naves e o preÃ§o delas e sua descriÃ§Ã£o
				For Local i= 0 Until 13
					SetColor(255,0,0)
					If i <6
						Player1.Pos_x=50*i+200
						Player1.Pos_y=75
						SetColor(255,0,0)
						smallFont.DrawText(i*15,50*i+200-10,75-30)
					Elseif i <12
						Player1.Pos_x=50*i-300+200
						Player1.Pos_y=150
						smallFont.DrawText( i*100-500,50*i-300+200-10,150-30)
					Elseif i= 12
						Player1.Pos_x=50*11-300+200
						Player1.Pos_y=250
						smallFont.DrawText(1000,50*11-300+200-15,250-30)
					End
					SetColor(255,255,255)
					Player1.Draw_Player(disco,i,1,hab[6].boolextra)
				
					If mouseONnavebool = True And mouseONnaveint = i
						
						
						SetColor(100,100,200)
						DrawRect(10,400,265,80)
						SetColor(0,0,0)
						smallFont.DrawText("SHIP NUMBER: "+(i+1),Largura_Habilidades+20,400)
						smallFont.DrawText("Numbers of skills to choose: "+ship[i].numberhab,10,400+15)
						smallFont.DrawText("Cooldown on touch to move: "+ship[i].CDmove+"millisecs",10,400+30)
						'smallFont.DrawText("Reduction Cooldown of all abilities: "+ship[i].CDred/1000+"s",10,400+45)
						'smallFont.DrawText("Descrition: ",Largura_Habilidades+20,400+60)
						SetColor(255,255,255)
					End
					
				
				
				
				End
				
				PushMatrix()
					SetColor(255,50,50)
					Translate(260,180)
					Scale(1.5,1.5)
					smallFont.DrawText("Record: "+Record,0,0)
					SetColor(0,0,0)
					smallFont.DrawText("Increase the",0,15)
					smallFont.DrawText("  RECORD",0,30)
					smallFont.DrawText("to get ships",0,45)
					SetColor(255,255,255)
				PopMatrix()
				
			
			
				sportsFont.DrawText("Start",640/2-50,400)
			Case 0.9'tela das habilidades
			
				'desenhando o limite esquerdo e direito da tela
					
				SetColor(0,0,0)
				DrawRect(0,0 , Largura_Habilidades,Altura_Tela)
		
				DrawRect(Comprimento_Tela-Largura_Habilidades,0,Largura_Habilidades,Altura_Tela)
				SetColor(255,255,255)
				
				
				'desenhando as habilidades e o put here
				For Local i:Int = 0 Until 32
		
					If slot[i].nomenu = True
					
						SetColor(50,50,50)
						DrawRect(slot[i].xmin,slot[i].ymin,SIZEICON,SIZEICON)
						SetColor(255,255,255)
						For Local j:Int = 0 Until 16
							If slot[i].index = hab[j].place
								If fullhab = True 
									SetColor (80,80,80)
								End
								
								DrawImage(habicon,slot[i].xmin ,slot[i].ymin,j)
								SetColor(255,255,255)
							End
							If drawONmouse = True
								SetColor(255,0,0)
							
									
								smallFont.DrawText("PUT",slot[i].xmin+15 ,slot[i].ymin+10)
								smallFont.DrawText("HERE",slot[i].xmin+10 ,slot[i].ymin+30)
									
							
								SetColor(255,255,255)
							End
						End
							
							
					
					Elseif slot[i].nomenu = False
						SetColor(255,255,0)
						smallFont.DrawText(+hab[slot[i].index].price,slot[i].xmin +10 ,slot[i].ymax)
						SetColor(255,255,255)
						If fullhab = True Or totalscore < hab[slot[i].index].price
							SetColor (80,80,80)
						End
					
						DrawImage(habicon,slot[i].xmin ,slot[i].ymin,slot[i].index)
						SetColor(255,255,255)
					end
				
				End
				
				
				
				SetColor(255,255,0)
				PushMatrix
					Translate(80 ,420)
					Scale(1.5,1.5)
					smallFont.DrawText("Total Score: "+totalscore,0 ,0)
				
				PopMatrix
				SetColor(255,255,255)
		
				
				
				
				
				
				
				
				'desenhando o icone no mouse 
				If drawONmouse = True
					DrawImage(habicon,TouchXscaled -SIZEICON/2 ,TouchYscaled -SIZEICON/2,habONmouse)
					
					
				End 
				
				
				'start
				sportsFont.DrawText("Start",640/2-50,400)
				sportsFont.DrawText("Reset",640-220,400)
				
				'descrevendo as habilidades
				If deschabONmouse = True Or drawONmouse = True 
					Local NAME:String
					Local CD:Int
					Local duration:Int
					Local desc1:String
					Local desc2:String
					If deschabONmouse = True
						NAME=hab[habONmouseFORdesc].NAME
						CD=hab[habONmouseFORdesc].CD
						duration=hab[habONmouseFORdesc].duration
						desc1 = hab[habONmouseFORdesc].desc1
						desc2 = hab[habONmouseFORdesc].desc2	
					End
					If drawONmouse = True
						NAME=hab[habONmouse].NAME
						CD=hab[habONmouse].CD
						duration=hab[habONmouse].duration
						desc1 = hab[habONmouse].desc1
						desc2 = hab[habONmouse].desc2	
						
					End
					
					
					SetColor(100,100,200)
					DrawRect(Largura_Habilidades+20,400,195,80)
					SetColor(0,0,0)
					smallFont.DrawText(NAME,Largura_Habilidades+20,400)
					smallFont.DrawText("Cooldown: "+CD/1000+"s",Largura_Habilidades+20,400+15)
					smallFont.DrawText("Duration: "+duration/1000+"s",Largura_Habilidades+20,400+30)
					smallFont.DrawText("Descrition: "+desc1,Largura_Habilidades+20,400+45)
					smallFont.DrawText(desc2,Largura_Habilidades+20,400+60)
				End
					
				
					
				
				
				
				
		#rem
		For Local j:Int = 0 Until 5	
			Local d1:Int 
			Local raio:Int = 10
			d1 = j*20
			If ((Abs(Player1.Pos_x - hab[i].x+d1*Cos(hab[i].floatextra))) < raio And (Abs(Player1.Pos_y - hab[i].y-d1*Sin(hab[i].floatextra))) <raio) Or
				((Abs(Player1.Pos_x - hab[i].x-d1*Cos(hab[i].floatextra))) < raio And (Abs(Player1.Pos_y - hab[i].y+d1*Sin(hab[i].floatextra))) <raio)

				Game_State = 2
			End
		
			#end
				
				
			Case 1 'tela do jogo
			
				'desenhando as habilidades
				If hab[0].DrawON = True 'dot
					hab[0].Draw0()
				End
				If hab[1].DrawON = True 'wall
					hab[1].Draw1()
					
					'desenhar bolas 
					#rem
					For Local j:Int = 0 Until 5
					
						Local d1:Int 
						Local raio:Int = 10
						d1 = j*20
					SetColor(0,0,255)
						DrawCircle(hab[1].x+d1*Cos(hab[1].floatextra),hab[1].y-d1*Sin(hab[1].floatextra),raio)
						DrawCircle(hab[1].x-d1*Cos(hab[1].floatextra), hab[1].y+d1*Sin(hab[1].floatextra),raio)
					SetColor(255,255,255)
					End
					#end
				End
				If hab[2].DrawON = True 'shield
					hab[2].Draw2()
				End
				If hab[3].DrawON = True 'localizaton
					For Local x:Int = Eachin objetos.Keys()
						hab[3].Draw3(objetos.Get(x).Pos_x,objetos.Get(x).Pos_y)
					End
						
				End
				If hab[4].DrawON = True 'explosion
					Local j:Int 
					Local k1:Float = hab[4].timestart + hab[4].duration
					Local k2:Float = Millisecs()
					Local k3:Float = hab[4].duration
					Local k4:Float 
					'Print(k1+" "+k2+" "+k3)
					k4 =(1-(k1-k2)/k3)
					'Print(k4)'+" 1 "+j)
					j = k4*21+5
					Print(j)
					
					If hab[4].boolextra = False
						explosionhab.DrawExp(j,True)
					Else
						explosionhab.DrawExp(15,True)
					End
					
					'hab[4].Draw4()
					
				End
				
				If hab[5].DrawON = True 'gravityoff
					SetColor(255,0,0)
					DrawCircle(hab[5].x,hab[5].y,15)
					SetColor(255,255,255)
				End
				
				
				If hab[7].DrawON = True 'dot
					For Local i:Int = 0 Until 8
						
						laser[i].Draw()
					End
				End
				If hab[8].DrawON = True 'missil
					hab[8].Draw8()
				End
				If hab[9].DrawON = True 'destroyenemyscreen
					hab[9].Draw9()
				End
				If hab[10].DrawON = True 'spinballs
					For Local i:Int = 0 Until 4
						ball[i].Draw()
						SetColor(0,0,0)
						smallFont.DrawText(ball[i].index,ball[i].x,ball[i].y)
						SetColor(255,255,255)
					End
				End
				
				If hab[11].DrawON = True 'web
					DrawImage(hab[11].anihab,hab[11].x,hab[11].y)
				End
				
				If hab[12].DrawON = True 'trail
					For Local i:Int = 0 Until 10
						trail[i].Draw()
						SetColor(0,0,0)
						'smallFont.DrawText(trail[i].index,trail[i].x,trail[i].y)
						SetColor(255,255,255)
					End
				End
				If hab[15].DrawON = True 'megawall
					hab[15].Draw15()
				End
				
				
				'desenhando score e tempo
				smallFont.DrawText("Your Score: "+Score,Largura_Habilidades+20,20)
				smallFont.DrawText("Time: "+timer+"s",Largura_Habilidades+20,35)
				If CDclickOFF = False
					SetColor(255,0,0)
					smallFont.DrawText("Boost: OFF ",Largura_Habilidades+20,50)
				Else
					SetColor(0,255,0)
					smallFont.DrawText("Boost: ON ",Largura_Habilidades+20,50)
				End
				SetColor(255,255,255)
				'desenhando sol, planetas, objetos e explosoes
				DrawImage(sun ,Comprimento_Tela/2, Altura_Tela/2)
				if	hab[14].DrawON = False
					Player1.Draw_Player(disco, number_ship,1,hab[6].boolextra)
				Else
					Player1.Draw_Player(disco, number_ship,hab[14].floatextra,hab[6].boolextra)
				End
				For Local x:Int = Eachin objetos.Keys()
				
					(objetos.Get(x)).Draw()
					
				End
				
				For Local x:Int = Eachin explosionMap.Keys()
					Local F:Int
					F =( Millisecs() - (explosionMap.Get(x)).timer)/10
					
					If F<31
						(explosionMap.Get(x)).DrawExp(F,False)
						
						Else
						explosionMap.Get(x).destruir = True
					End
					 
				End
				'desenhando o limite esquerdo e direito da tela
				
				SetColor(0,0,0)
				DrawRect(0,0 , Largura_Habilidades,Altura_Tela)
	
				DrawRect(Comprimento_Tela-Largura_Habilidades,0,Largura_Habilidades,Altura_Tela)
				SetColor(255,255,255)
				
			
				'desenhando os CD
				
				For Local i:Int = 0 Until 16
				SetColor(255,255,255)
					If hab[i].place <> -1
						If hab[i].podeserativada = False
							SetColor(50,50,50)
						End
						DrawImage(habicon,slot[hab[i].place].xmin ,slot[hab[i].place].ymin,i)
					
						
						
						If hab[i].podeserativada = False
							SetColor(30,30,150)
							If hab[i].drawCDdown = False 
								
								DrawRect(slot[hab[i].place].xmin ,slot[hab[i].place].ymax,SIZEICON, -SIZEICON)
								
							Else
								Local temp:Float = 0
								
								temp = Millisecs()
								DrawRect(slot[hab[i].place].xmin ,slot[hab[i].place].ymax,SIZEICON, -SIZEICON*((hab[i].timeCD-temp)/hab[i].CD))
								
							End
							'desenhar numeros nos CD
							#rem
							Local xt:Int = slot[hab[i].place].xmin+4
							Local yt:Int = slot[hab[i].place].ymin+4
							If (hab[i].timeCD-Millisecs())/1000 < 10
								xt = slot[hab[i].place].xmin+7 
								yt = slot[hab[i].place].ymin+4
							End
							
							
							SetColor(255,0,0)
							PushMatrix
								Translate(xt ,yt)
								Scale(3,3)
								smallFont.DrawText((hab[i].timeCD-Millisecs())/1000,0,0)
							PopMatrix
							#end
						End
						
						
						
						
					End
				End
				
				SetColor(255,255,255)
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			Case 2 'tela final
			
				font_bluesky.DrawText("Protect the Spaceship",100,50)
				'DrawText("mouse : "+MouseX+" , "+MouseY,10,30)
				sportsFont.DrawText("Play",160,300)
				sportsFont.DrawText("Menu",400,300)
				
				
				
				PushMatrix()
					SetColor(255,50,50)
					Translate(260,180)
					Scale(1.5,1.5)
					smallFont.DrawText("Record: "+Record,0,0)
					SetColor(255,255,0)
					smallFont.DrawText("Total Score: "+totalscore,0,15)
					SetColor(150,150,220)
					smallFont.DrawText("Score: "+Score,0,30)
					smallFont.DrawText("Time: "+timer+"s",0,45)
					If Score = 0
						SetColor(255,165,0)
						smallFont.DrawText("HINT: Click FAR to the ship go FASTER.",-85,-40)
						smallFont.DrawText("Go around the sun could help.",-65,-25)
						SetColor(255,255,255)
					End
					If DrawNewRecord = True
						SetColor(255,255,255)
						'DrawRect(-120,100 , 290,20)
						
						SetColor(0,0,255)
					
						'smallFont.DrawText("CLICK TO SHARE YOUR RECORD ON FACEBOOK",-120,100)
						
						SetColor(((Millisecs() Mod (100*5))/5)+150,100,100)
						sportsFont.DrawText("NEW RECORD!!!",-130,-50)
						
					End
					
				PopMatrix()
				
				'DrawText("Touch : "+TouchX+" , "+TouchY,10,40)
				'DrawText("Your Score: "+Score,300,150)
				'DrawText("Record: "+Record,300,200)
				'DrawText("Press ENTER to play again : ",300,300)
				'DrawText("Press Esc to return to main menu : ",300,280)
				
			End
	PopMatrix()
	'DrawText("Touch : "+TouchXscaled+" , "+TouchYscaled,10,500)
	
	End
	
	Method OnLoading()
	
	End
	
	Method OnSuspend()
	
	End
	
	Method OnResume()
	
	End
	
	
	
	
End








Class Player
	Field Pos_x:Float =0.00
	Field Pos_y:Float =0.00
	Field Rot:Float = 0.00
	Field rotvel:Float = 0.00
	Field Vel_x:Float =0.00
	Field Vel_y:Float =0.00
	Field ace_x:Float =0.00
	Field ace_y:Float =0.00
	Field explosion:Bool = False
	Field total_dist:Float =0.00
	Field corhab6:Int = 0
	Method New()


		Self.Pos_x = Comprimento_Tela/2
		Self.Pos_y = Altura_Tela/4
		Self.Vel_x= 3
		Self.Vel_y=0
		
	End
	
	Method Draw_Player(ship:Image,number:Int,escala:Float,hab6boolextra:Bool)

		Local ExpFrame:Int
		
		If number < 12
			ExpFrame = number
		Elseif number = 12
			ExpFrame = (Millisecs()/80 Mod 10)+12
		End
		
		
		PushMatrix
		Translate(Pos_x,Pos_y)
		
		If Game_State = 1
			Rot += 11*rotvel
		End
		Rot += rotvel
		Rotate(Rot)
		
		
		Scale(escala, escala)
	
		If hab6boolextra = False
			If corhab6 = 0
				corhab6 =0
			End
			If corhab6 < 250
				corhab6 +=2
			End
			
			
			SetColor(corhab6,corhab6,corhab6)
		End
		
		DrawImage(ship, 0,0,ExpFrame)
		
		
		
		SetColor(255,255,255)
		'DrawRect( -15, -15, 30,30 )
		PopMatrix

	End

	Method Gravidade(gravidadeoff:Bool,web:Bool)
		Local dist_x:Float =0.00
		Local dist_y:Float =0.00
		
		

	
		dist_x= (Comprimento_Tela/2 - Pos_x)
		dist_y= (Altura_Tela/2 - Pos_y)
		
		total_dist = Sqrt((dist_x*dist_x)+(dist_y*dist_y))
		
		If total_dist < RAIO_SOL + RAIO_NAVE
			Game_State = 2
			explosion = True
			
			
		Else
			ace_x=dist_x*(10/(total_dist*total_dist))
			ace_y = dist_y*(10/(total_dist*total_dist))
		End
		If web = False
			ace_x=ace_x*0.95
			ace_y =ace_y*0.95
		End
		
	
		
		If gravidadeoff= False
			Vel_x += ace_x
			Vel_y += ace_y
		End
		 
		If web = False
			Vel_x = Vel_x*0.95
			Vel_y =Vel_y*0.95
		End
		
		Pos_x =Pos_x + Vel_x
		Pos_y =Pos_y + Vel_y
		
	
	End
	
	Method Touch()
	
		Local dist_x:Float =0.00
		Local dist_y:Float =0.00
		Local total_dist:Float =0.00
		Local TempVel_x:Float =0.00
		Local TempVel_y:Float =0.00
		
		dist_x= (TouchXscaled - Pos_x)
		dist_y= (TouchYscaled - Pos_y)
		total_dist = Sqrt((dist_x*dist_x)+(dist_y*dist_y))
		
		TempVel_x = dist_x/50
		TempVel_y = dist_y/50
		
		Vel_x = TempVel_x 
		Vel_y = TempVel_y
	End
	
	Method Reset()
		total_dist=0.00
		Pos_x=Comprimento_Tela/2
		Pos_y=Altura_Tela/4
		Vel_x=3
		Vel_y=0
		ace_x=0
		ace_y=0
		corhab6 = 0
	
	End

End

Class objeto

	Field Pos_x:Float = 0.00
	Field Pos_y:Float = 0.00
	Field Rot:Float
	Field Vel_x:Float = 0.00
	Field Vel_y:Float = 0.00
	Field ace_x:Float = 0.00
	Field ace_y:Float = 0.00
	Field destruir:Bool = False
	Field img:Image
	Field imgint:Int
	Field explosion:Bool = False
	
	Method New()
		Local random1:Int
		Local random_Rot:Int
		Local random_Pos_x:Int
	
		imgint =Rnd(52)
		
		
		

		random1 = Rnd(4)
		Select random1
			Case 0 
				Self.Pos_x = Rnd(-100,Comprimento_Tela+100)
				Self.Pos_y = Rnd(-100, -10)
				
			Case 1
				Self.Pos_x = Rnd(Comprimento_Tela+10,Comprimento_Tela+100)
				Self.Pos_y = Rnd(-100,Altura_Tela+100)
				
			Case 2
				Self.Pos_x = Rnd(-100,Comprimento_Tela+100 )
				Self.Pos_y = Rnd(Altura_Tela+10,Altura_Tela+100)
			
			Case 3
				Self.Pos_x = Rnd(-10, -100)
				Self.Pos_y = Rnd(-100, Altura_Tela+100)
				
		End
		
	
		
	
		Self.Rot =  Rnd(-50,50)
		Self.Vel_x= Rnd(-3,3)
		Self.Vel_y=Rnd(-3,3)
		
	End
	Method Gravidade(web:Bool)
		Local dist_x:Float =0.00
		Local dist_y:Float =0.00
		Local total_dist:Float =0.00
	
	
		
	
		dist_x= (Comprimento_Tela/2 - Pos_x)
		dist_y= (Altura_Tela/2 - Pos_y)
		
		total_dist = Sqrt((dist_x*dist_x)+(dist_y*dist_y))
		
		If  total_dist < RAIO_SOL + RAIO_OBJETO
			destruir = True
			explosion = True
			
		Else
			ace_x=dist_x*(10/(total_dist*total_dist))
			ace_y = dist_y*(10/(total_dist*total_dist))
		End
		If web = False
			ace_x=ace_x*0.95
			ace_y =ace_y*0.95
		End
		Vel_x += ace_x
		Vel_y += ace_y
	
		If web = False
			Vel_x=Vel_x*0.95
			Vel_y=Vel_y*0.95
			
			
			
			
		End
		
		Pos_x =Pos_x + Vel_x
		Pos_y =Pos_y + Vel_y

	
	End

	Method Draw()
		PushMatrix()
		
			Translate(Pos_x,Pos_y)
			
			
			If Rot <> 0
				Rotate(Millisecs()/Rot)
			End
			DrawImage(img, 0,0,imgint)
		PopMatrix()
	End
	
End

Class Explosion
	Field x:Int
	Field y:Int
	Field exp:Image
	Field destruir:Bool = False
	Field timer:Int
	Field channel:Int
	Method New(exp:Image,x:Float,y:Float)
	Self.x=x
	Self.y=y
	Self.exp= exp
	Self.timer= Millisecs()
	
	End

	Method DrawExp(F:Int, hab:Bool)
		
		
		DrawImage(exp, x,y,F)
		
		If hab = True
			
			PushMatrix
				
				Translate(x,y)
				Scale(10,10)
				DrawImage(exp, 0,0,F)
			PopMatrix
			'DrawCircle(x,y,140)
		End
		
	End
End
Class tiro 'laser
	Field x:Float
	Field y:Float
	Field vel_x:Float
	Field vel_y:Float
	Field rot:Float
	
	Method New(j:Int)
	rot = j *45
	End
	
	
	Method Update1(Player1x:Float,Player1y:Float,Player1vel_x:Float,Player1vel_y:Float)
		x = Player1x
		y = Player1y
		vel_x = Player1vel_x
		vel_y = Player1vel_y
	End
	
	Method Update2()

	x = x + vel_x + 10*Sin(rot)
	y = y + vel_y + 10*Cos(rot)
	
	
	End
	
	Method Draw()
	
		PushMatrix()
			Translate(x,y)
			Rotate(rot)
			SetColor(255,0,0)
			DrawRect(-1,-10,2, 20)
			SetColor(255,255,255)
		PopMatrix()
	End
	Method Reset()
	x=0
	y=0
	
	End
	
End


Class spinballs 'spinballs
	Field x:Float
	Field y:Float
	Field vel_x:Float
	Field vel_y:Float
	Field rot:Float
	Field index:Int
	Field anihab10:Image
	Method New(j:Int)
		index = j 
		anihab10 = LoadImage("anihab10.png",20, 20,1 ,Image.MidHandle)
	End
	
	Method Update(Pos_x:Float,Pos_y:Float)
	Local distancia:Int = 75
	
	rot = Millisecs/10

		Select index
			Case 0
			
			x=Pos_x +distancia*Cos(rot)
			y=Pos_y +distancia*Sin(rot)
			Case 1
			x=Pos_x -distancia*Cos(rot)
			y=Pos_y -distancia*Sin(rot)
			
			Case 2
			
			x=Pos_x -distancia*Sin(rot)
			y=Pos_y +distancia*Cos(rot)
			Case 3
			x=Pos_x +distancia*Sin(rot)
			y=Pos_y -distancia*Cos(rot)
		End
	
	
	End
	
	Method Draw()
		PushMatrix()
			Translate(x,y)
			DrawImage(anihab10,0,0)
			'DrawCircle(0,0,10)
			
		PopMatrix()
	
	
	End
	
	
	
	Method Reset()
		x=0
		y=0
		vel_x = 0
		vel_y = 0
		rot= 0
	End
End


Class trails

	Field x:Float = -200
	Field y:Float = -200
	Field rot:Float
	Field index:Int
	Field first:Bool = True
	Method New(j:Int)
		index = j 
	End
	Method Update(Pos_x:Float,Pos_y:Float,timestart:Int)
	
		If index*500 + timestart < Millisecs() And first = True

			x=Pos_x
			y=Pos_y
			first = False
		
		End 

	End
	
	Method Draw()
	
		If first = False
			SetColor(200,200,200)
			DrawCircle(x,y,4)
			SetColor(255,255,255)
		End
	End


	
	Method Reset()
		x=-200
		y=-200
		rot= 0
		first = True
	End
End

Class Ships
	Field index:Int
	Field CDred:Int
	Field numberhab:Int
	Field CDmove:Int
	
	Method New(i:Int)
		index = i
		CDred = i*1000
		numberhab = i+1
		CDmove = 1000 - i*50
		If i = 12
		
			numberhab = 16
			CDmove = 300
		End
		
	End
End


Class Slots

	Field xmin:Int
	Field xmax:Int
	Field ymin:Int
	Field ymax:Int
	Field index:Int
	Field nomenu:Bool

	Method New(i:Int,xmin:Int,xmax:Int ,ymin:Int,ymax:Int, nomenu:Bool  )
	Self.xmin = xmin
	Self.xmax = xmax 
	Self.ymin = ymin
	Self.ymax = ymax
	Self.index = i
	Self.nomenu = nomenu
	
	
	End
End


Class habilidades
	Field NAME:String
	Field name:String 
	Field index:Int
	Field place:Int
	Field ativada:Bool
	Field podeserativada:Bool

	Field timestart:Int
	Field timeCD:Int
	Field CD:Int
	Field duration:Int
	Field Mode:Int = 0
	Field img:Image
	Field DrawON:Bool = False
	Field x:Float
	Field y:Float
	Field floatextra:Float = 0 'particular para cada magia: wall missil small
	Field intextra:Int = 0 'particular para cada magia: missil destroyenemyscreen megawall teleport
	Field boolextra:Bool = True 'particular para cada magia: missil destroyenemyscreen web megawall explositon teleport
	Field raio:Int
	Field drawCDdown:Bool = False
	Field price:Int
	Field desc1:String
	Field desc2:String
	Field anihab:Image
	Field icon:Image
	Method New (i:Int)
		Select i
			Case 0
				Self.NAME = "Dot"
				Self.name = "dot"
				Self.index = i
				Self.CD = 30000
				Self.duration = 20000
				Self.raio = 10
				Self.desc1 = "Creates a dot on"
				Self.desc2 = "the screen"
				Self.anihab = LoadImage("anihab0.png",20, 20,1 ,Image.MidHandle)
				
			Case 1
				Self.NAME = "Wall"
				self.name =  "wall"
				Self.index = i
				Self.CD = 30000
				Self.duration = 8000
				Self.raio = 10
				Self.desc1 = "Creates a wall on"
				Self.desc2 = "the screen"
				Self.anihab = LoadImage("anihab1.png",180, 20,1 ,Image.MidHandle)
			
			Case 2
				Self.NAME = "Shield"
				self.name =  "shield"
				Self.index = i
				Self.CD = 60000
				Self.duration = 5000
				Self.raio = 40
				Self.desc1 = "Creates a shield"
				Self.desc2 = "around the player"
			Case 3
				Self.NAME = "Radar"
				self.name =  "localization"
				Self.index = i
				Self.CD = 45000
				Self.duration = 15000
				Self.desc1 = "Localize the "
				Self.desc2 = "planets off the screen"
			Case 4
				Self.NAME = "Explosion"
				self.name =  "explosion"
				Self.index = i
				Self.CD = 25000
				Self.duration = 200
				Self.raio = 140
				Self.desc1 = "Do an explosion"
				Self.desc2 = "over an area"
				
			Case 5
				Self.NAME = "Gravity off"
				self.name =  "gravityoff"
				Self.index = i
				Self.CD = 60000
				Self.duration = 15000
				Self.desc1 = "Turn off the"
				Self.desc2 = "gravity for player"
			Case 6
				Self.NAME = "Teleport"
				self.name =  "teleport"
				Self.index = i
				Self.CD = 60000
				Self.duration = 500
				Self.desc1 = "Teleport the player"
				Self.desc2 = "instantly"
			Case 7
				Self.NAME = "Lasers"
				self.name =  "laser"
				Self.index = i
				Self.CD = 40000
				Self.duration = 2000
				Self.raio = 10
				Self.desc1 = "Fires 8 lasers"
				Self.desc2 = ""
			Case 8
				Self.NAME = "Guided missile"
				self.name =  "missil"
				Self.index = i
				Self.CD = 40000
				Self.duration = 2000
				Self.raio = 10
				Self.desc1 = "Fires a guided"
				Self.desc2 = "missile to a planet"
				Self.anihab = LoadImage("anihab8.png",20, 20,1 ,Image.MidHandle)
			Case 9
				Self.NAME = "Apocalypse"
				self.name =  "destroyenemyscreen"
				Self.index = i
				Self.CD = 60000
				Self.duration = 500
				Self.desc1 = "Destroy everything"
				Self.desc2 = "in the screen"
			Case 10
				Self.NAME = "Spin balls"
				self.name =  "spinballs"
				Self.index = i
				Self.CD = 50000
				Self.duration = 8000
				Self.raio = 10
				Self.desc1 = "Creates 4 balls"
				Self.desc2 = "that rotates the player"
				
			Case 11
				Self.NAME = "Web"
				self.name =  "web"
				Self.index = i
				Self.CD = 60000
				Self.duration = 15000
				Self.raio = 70
				Self.desc1 = "Creates a web"
				Self.desc2 = "that slows over an area"
				Self.anihab = LoadImage("anihab11.png",140, 140,1 ,Image.MidHandle)
			Case 12
				Self.NAME = "Trail"
				self.name =  "trail"
				Self.index = i
				Self.CD = 40000
				Self.duration = 5000
				Self.raio = 1
				Self.desc1 = "Creates many mines"
				Self.desc2 = "over the player's path"
			
			Case 13
				Self.NAME = "Stop"
				self.name =  "stop"
				Self.index = i
				Self.CD = 60000
				Self.duration = 1000
				Self.desc1 = "Stops every planet"
				Self.desc2 = "over the game"
			Case 14
				Self.NAME = "Small"
				self.name =  "small"
				Self.index = i
				Self.CD = 50000
				Self.duration = 15000
				Self.desc1 = "Decreases the"
				Self.desc2 = "chance of being struck"
			Case 15
				Self.NAME = "Megawall"
				self.name =  "megawall"
				Self.index = i
				Self.CD = 60000
				Self.duration = 10000
				Self.raio = 2
				Self.desc1 = "Creates a big wall"
				Self.desc2 = "randomly over one of 4 sides"
		End
		Self.ativada = False
		Self.podeserativada = True
		Self.Mode = 0
		Self.DrawON = False
		
		If i =0
		Self.price = 0
		
		Elseif i>=1
		Self.price = Pow(i,3)*5
	
		End
		
		
	End
	
	Method Update0()' dot, wall explosion teleport
		Self.x = TouchXscaled
		Self.y = TouchYscaled	
	End
	
	Method Update2(Pos_x:Float,Pos_y:Float) 'Shield gravityoff
		x = Pos_x
		y = Pos_y
	End
	Method Draw0() ' dot 
		SetColor(255,255,255)
		'DrawCircle(x,y,10)
		DrawImage(anihab,x,y)
	End
	
	Method Update8_0(x1:Float,y1:Float) 'missil
		x = x1
		y = y1
	
	End
	
	Method Update8_1(objx:Float,objy:Float) ' missil
		
		If boolextra = True
			floatextra =ATan2( objy -y ,objx -x )
		End
		x = x + 5*Cos(floatextra)
		y = y + 5*Sin(floatextra)
		
		
	End
	Method Update15() 'megawall
	
		intextra =Rnd(4)
		
		Select intextra
		
			Case 0 'up
			 x = Largura_Habilidades 
			 y= 20
			 boolextra = True 'horizontal?
			Case 1 'right
			x = Comprimento_Tela - Largura_Habilidades -20
			y = 0
			boolextra = False
			Case 2 'down
			x= Largura_Habilidades
			y = Altura_Tela -20
			
			boolextra = True
			Case 3 'left
			x = Largura_Habilidades  +20
			y=0
			boolextra = False
		End
		
		
	End

	
	
	Method Draw1() ' wall

		If Mode <= 1
			
			floatextra = Millisecs()/5
		End
		PushMatrix()
			Translate(x,y)
			Rotate(floatextra)
			
			DrawImage(anihab,0,0)
			SetColor(255,255,255)
			'DrawRect(0,0,100,5)
			'DrawRect(0,0,-100,5)
		PopMatrix()
		
		
		
		'SetColor (255,0,0)
		'DrawCircle(x,y,20)
	
		'DrawCircle(x+40*Cos(floatextra),y-40*Sin(floatextra),20)
		'DrawCircle(x-40*Cos(floatextra),y+40*Sin(floatextra),20)
		SetColor(255,255,255)
		
	End
	
	
	Method reset_NOpodeserativada_NOtimeCD_NOdrawCDdown()
		Self.ativada = False
		Self.timestart = 0
		Self.Mode = 0
		Self.DrawON = False
		Self.floatextra = 0 
		Self.intextra = 0
		Self.boolextra = True
		Self.x=0
		Self.y=0
	End
	Method reset()
		Self.x=0
		Self.y=0
		Self.ativada = False
		Self.podeserativada = True
		Self.timestart = 0
		Self.timeCD = 0
		Self.Mode = 0
		Self.DrawON = False
		Self.floatextra = 0 
		Self.intextra = 0
		Self.boolextra = True
		Self.drawCDdown = False
	End
	Method Draw2() 'Shield
		SetColor(175,238,238)
		DrawCircle(x,y,40)
		SetColor(255,255,255)
	End
	Method Draw3(x:Float, y:Float) 'localization
		Local altura:Int
		Local comprimento:Int
		Local Drawx:Float
		Local Drawy:Float
		
		Local rot:Int =0
		altura= 15
		comprimento = 1
		
		
			If x <= 60
				If y<0
				
					rot = 45
					Drawx= Largura_Habilidades
					Drawy = 0
						
				Elseif y<= Altura_Tela
					rot= 90
					
					Drawx= Largura_Habilidades
					Drawy = y
				Elseif  y> Altura_Tela
		
					rot = 135
				
					Drawx= Largura_Habilidades
					Drawy = Altura_Tela
				End
			Elseif x<= Comprimento_Tela-Largura_Habilidades
				If y<0
					
					Drawx= x
					Drawy = 0
				Elseif y<= Altura_Tela
				'nada
				Elseif  y> Altura_Tela
					rot=180
					Drawx= x
					Drawy = Altura_Tela 
				End
			Elseif  x> Comprimento_Tela-Largura_Habilidades
				If y<0
					rot = -45
					
					Drawx= Comprimento_Tela-Largura_Habilidades
					Drawy = 0
				Elseif y<= Altura_Tela
					rot = -90
					Drawx= Comprimento_Tela-Largura_Habilidades
					Drawy = y
				Elseif  y> Altura_Tela
					rot = -135
				
					Drawx= Comprimento_Tela-Largura_Habilidades
					Drawy = Altura_Tela
				End
			End
			PushMatrix()
				Translate(Drawx,Drawy)
				If rot <> 0
					Rotate(rot)
					
				End
				SetColor (255,0,0)
				DrawRect(0,0,comprimento,altura)
		
				SetColor (255,255,255)
		
			PopMatrix()
	End
	Method Draw4() '  web
		SetColor(255,255,255)
		
		
		DrawCircle(x,y,90)
	End
	
	Method Draw8() ' missil
		'SetColor(255,255,255)
		'DrawCircle(x,y,10)
		DrawImage(anihab,x,y)
	End
	Method Draw9() 'destroyenemyscreen
		If intextra < 240 And boolextra = True
			intextra +=5
		Else
			intextra -=10
			boolextra = False
		End
		Cls(intextra,intextra,intextra)
	End
	Method Draw15() ' megawall
		SetColor(153,50,205)
		If boolextra = True
			DrawRect(x,y,Comprimento_Tela- 2*Largura_Habilidades, 2 )
			DrawRect(x,y,Comprimento_Tela- 2*Largura_Habilidades, -2 )
		Else
			DrawRect(x,y,2 ,Altura_Tela )
			DrawRect(x,y,-2 ,Altura_Tela )
		End
		SetColor(255,255,255)
	
	
	End
	
	
	
End




Function Main()
	
	
	New MyGame()

	
End