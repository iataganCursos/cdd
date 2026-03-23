#include "directry.ch"
TELA()

DECLARE ARQUIVOS := {}, NOMES := {}, ARQ := {}, oFile, CONT := .T., ASP:=0
DO WHILE .T.
	CONT = .T.
	DO WHILE CONT
		NOMES := {}
		ARQ := {}
		@ 2,1 CLEAR TO MAXROW()-2-4,19
		@ 2,22 CLEAR TO MAXROW()-2-4,MAXCOL()-2
		ARQUIVOS := DIRECTORY("*.*", "D")
		AADD(NOMES, "..")
		AADD(NOMES, "/" )
	   	FOR EACH oFile IN ARQUIVOS
	      		DO CASE
	      		CASE oFile[ F_NAME ] == "." .OR. oFile[ F_NAME ] == ".."
	      		CASE oFile[ F_NAME ] == "Program Files"
	         		AADD(NOMES, oFile[ F_NAME ])
	      		CASE oFile[ F_NAME ] == "Program Files (x86)"
	         		AADD(NOMES, oFile[ F_NAME ])
	      		CASE oFile[ F_NAME ] == "Users"
	         		AADD(NOMES, oFile[ F_NAME ])
	      		CASE oFile[ F_ATTR ] == "D"
	         		AADD(NOMES, oFile[ F_NAME ])
	      		OTHERWISE
	         		AAdd( ARQ, oFile[ F_NAME ] )
	      		ENDCASE
	   	NEXT
		FOR I = 1 TO MAXROW()-1-6
			IF I <= LEN(ARQ)
				@ I+1, 22 SAY ARQ[I]
 			ENDIF
		NEXT
		ESCOLHA := ACHOICE( 2, 1, MAXROW()-2-4, 19, NOMES)
		MENU()
		ASP = LASTKEY()
		IF ESCOLHA != 0
			DirChange(NOMES[ESCOLHA])
		ENDIF
		IF ASP == 4
			CONT = .F.
		ELSEIF ASP == 19
			CONT = .F.
		ENDIF
	ENDDO
	@ 2,22 CLEAR TO MAXROW()-2-4,MAXCOL()-2
		FOR I = 1 TO MAXROW()-1-6
			IF I <= LEN(NOMES)
				@ I+1, 1 SAY SUBSTR(NOMES[I],0,19)
 			ENDIF
		NEXT
	ESCOLHA := ACHOICE( 2, 22, MAXROW()-2-4, MAXCOL()-1, ARQ)
	MENU()
	IF ESCOLHA != 0
		RUN(ARQ[ESCOLHA])
	ENDIF
	NOMES := {}
	@ 2,22 CLEAR TO MAXROW()-2-4,MAXCOL()-2
ENDDO

FUNCTION MENU()
	LOCAL TESTE, ASP:=0
	TESTE = LASTKEY()
	IF TESTE == 27 // TECLA EXC
		@ MAXROW()-16,7 TO MAXROW()-0,23 DOUBLE
		@ MAXROW()-15,8  PROMPT "Start          "
		@ MAXROW()-14,8  PROMPT "Path           "
		@ MAXROW()-13,8  PROMPT "Driver         "
		@ MAXROW()-12,8  PROMPT "Open with      "
		@ MAXROW()-11,8  PROMPT "Search         "
		@ MAXROW()-10,8  PROMPT "Cut Ctrl + X   "
		@ MAXROW()-09,8  PROMPT "Copy Ctrl + C  "
		@ MAXROW()-08,8  PROMPT "Paste Ctrl + V "
		@ MAXROW()-07,8  PROMPT "Delete DELETE  "
		@ MAXROW()-06,8 PROMPT "Rename         "
		@ MAXROW()-05,8 PROMPT "New Folder     "
		@ MAXROW()-04,8 PROMPT "Compact        "
		@ MAXROW()-03,8 PROMPT "Order by" + chr(16) + "      "
		@ MAXROW()-02,8 PROMPT "About" + chr(16) + "         "
		@ MAXROW()-01,8 PROMPT "Exit           "
		MENU TO OPC

		ASP = LASTKEY()
		IF ASP == 27
			CLS
			CANCEL
		ENDIF

		DO CASE
		CASE OPC == 13
			@ MAXROW()-05,14 TO MAXROW()-0,25 DOUBLE
			@ MAXROW()-04,15 PROMPT "Name      "
			@ MAXROW()-03,15 PROMPT "Type      "
			@ MAXROW()-02,15 PROMPT "Date      "
			@ MAXROW()-01,15 PROMPT "Size      "
			MENU TO OPCx
		CASE OPC == 14
			@ 09,((MAXCOL()-30)/2)-1 TO 15,((MAXCOL()-30)/2)+30 DOUBLE
			@ 10,(MAXCOL()-30)/2 say "Name: Jorge Luiz Gouveia Sousa"
			@ 11,(MAXCOL()-30)/2 say "WhatsApp: +55 86 99460-2968   "
			@ 12,(MAXCOL()-30)/2 say "E-mail: jas5868aa@gmail.com   "
			@ 13,(MAXCOL()-30)/2 say "Site: www.ouka.com.br         "
			@ 14,(MAXCOL()-30)/2 say "Blog: jorgeia.blogspot.com    "
			INKEY(0)
		CASE OPC == 15
			CLS
			CANCEL
		ENDCASE
	ENDIF

	TELA()
RETURN NIL

FUNCTION TELA()
	CLS
	@ 0,0 say "CDD File Manager"

	@ 1,0 TO MAXROW()-1-4,20 DOUBLE
	@ 1,21 TO MAXROW()-1-4,MAXCOL() DOUBLE

	@ MAXROW()-4,0 say "Path  :"
	@ MAXROW()-3,0 say "Folder:"
	@ MAXROW()-2,0 say "File  :"
	@ MAXROW()-1,0 say "Menu  " + chr(16)
	@ MAXROW()-0,0 say "Esc=Menu/Exit  "+chr(24)+chr(25)+chr(27)+chr(26)+"=Move  Space=Select  Enter=Execute   Cut=Ctrl+X   Copy=Ctrl+C   Paste=Ctrl+V   Delete=DELETE"
	@ 1,20  say chr(24)
	@ 1,MAXCOL() say chr(24)

	for x=2 to MAXROW()-1-4
		@ x,20 say chr(176)
		@ x,MAXCOL() say chr(176)
	next

	@ MAXROW()-1-4,20 say chr(25)
	@ MAXROW()-1-4,MAXCOL() say chr(25)
RETURN NIL

function caracteres()
	@ 0,0 say ""
	FOR i = 0 TO 255
		?? chr(i) , "=" , alltrim(str(i)) , " "
	NEXT
	INKEY(0)
return nil
