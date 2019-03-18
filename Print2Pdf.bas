'print2pdf cmd line tool v1.3   18 March 2019  by Marpon  marpon@aliceadsl.fr



#include once ".\print2pdf.bi"		' for pdf convertion : txt, pictures
									'  and more if exists 'Microsoft print to pdf' virtual printer


sub help_usage()
	dim as string mess = chr(10,10)
	mess &=  "Print2Pdf.exe  v:1.0    16-March-2019    by marpon   contact : marpon@aliceadsl.fr" & chr(10)
	mess &=  "     It's a free command line tool to convert various files to pdf," & chr(10)
	mess &=  "     it could (in win10), depending the files, use : 'Microsoft Print to Pdf' virtual printer to proceed." & chr(10,10,10)
	mess &=  "Usage  :  Print2Pdf [option] [replace] ""Full_File_Path_for_File_to_Convert""  [""Full_File_Path_for_Pdf""]" & chr(10,10)
	mess &=  "          where option can be one of these choices:" & chr(10)
	mess &=  "            -h  or --help      shows that usage" & chr(10)
	mess &=  "            -n  or --nothing   nothing shown, even in error case" & chr(10)
	mess &=  "            -v  or --verbose   to show errors only, via messagebox  " & chr(10)
	mess &=  "            -d  or --debugg    to show all the steps of the process, via console" & chr(10,10)
	mess &=  "            if none of these choices, the default mode is '--nothing'," & chr(10)
	mess &=  "               except if no argument at all, in that case that usage information will be shown " & chr(10,10)
	mess &=  "          where replace can be one of these choices:" & chr(10)
	mess &=  "            -a  or --ask       asks if want to replace existing destination file" & chr(10)
	mess &=  "            -f  or --force     forces always to replace existing destination file" & chr(10)
	mess &=  "            if none of these choices, the default mode is not replacing!" & chr(10,10,10)
	mess &=  "     The only absolutely needed argument is : ""Full_File_Path_for_File_to_Convert""" & chr(10,10)
	mess &=  "         if ""Full_File_Path_for_Pdf"" is not given, the pdf file will be created " & chr(10)
	mess &=  "         in the same folder as the source file, with the same name," & chr(10)
	mess &=  "         except the extention that will be changed to '.pdf' " & chr(10,10,10)
	dim as long cons_type = check_cmd()
	if cons_type < 0 THEN									'GUI mode
		dim as dword ppid = getParentPID(GetCurrentProcessId())
		if  ppid > 0  THEN
			fflush(STDIN)
			fflush(STDOUT)
			fflush(STDERR)
			AttachConsole(ppid)
			if GetConsoleWindow() THEN						'GUI mode :launched via prompt cmd
				freopen( "CON", "r", stdin )
				freopen( "CON", "w", stdout )
				freopen( "CON", "w", stderr )
				'printf(!"\n\nGUI : Using the existing launching console\n")
				printf(!"\n\n%s\n\n", strptr(mess))
				restore_true_console(ppid)
			else											'GUI mode :launched without prompt cmd
				if in_console(1, "Print2Pdf :    Warning console") then
					'printf(!"GUI : Created new console\n")
					printf(!"\n\n%s\n\n", strptr(mess))
					printf(!"Press any key or close that console window to stop!\n\n")
					sleep -1
				else
					messagebox 0, mess, "Print2Pdf  usage", 0
				end if
			END IF
		else
			messagebox 0, mess, "Print2Pdf  usage", 0
		END IF
	elseif cons_type = 0 THEN								'console mode :launched without prompt cmd
		'printf(!"\nIn 'real' console mode using own console\n")
		printf(!"\n\n%s\n\n", strptr(mess))
		printf(!"Press any key or close that console window to stop!\n\n")
		sleep -1
	else													'console mode :launched via prompt cmd
		'printf(!"\nIn 'real' console mode using the existing launching console\n")
		printf(!"\n\n%s\n\n", strptr(mess))
	END IF

END SUB




dim as string s_in
dim as string s_out
dim as string ss1


Dim As long i = 1
dim as long iflag = 0
dim as long iforce = 0
dim as long iparam = 0
Do
    Dim As String ss1 = Command(i)
    If Len(ss1) <> 0 Then
		If (LCase(ss1) = "-n" or LCase(ss1) = "--nothing")  and iflag = 0 Then
			iflag = -1
        elseif (LCase(ss1) = "-v" or LCase(ss1) = "--verbose") and iflag = 0 Then
            iflag = 1
		elseif (LCase(ss1) = "-d" or LCase(ss1) = "--debugg") and iflag = 0 Then
            iflag = 2
		elseif (LCase(ss1) = "-h" or LCase(ss1) = "--help") and iflag = 0 Then
			help_usage()
			end 0
		elseif (LCase(ss1) = "-f" or LCase(ss1) = "--force") and iforce = 0 Then
			iforce = 2
		elseif (LCase(ss1) = "-a" or LCase(ss1) = "--ask") and iforce = 0 Then
			iforce = 1
		else
			if iparam = 0 THEN
				s_in = ss1
				iparam = 1
			elseif iparam = 1 then
				s_out = ss1
				iparam = 2
            END IF
		end if

    end if
    i += 1
Loop until i = 10

if iflag = -1  and iparam = 0 THEN end 1

if iparam = 0 THEN
	help_usage()
	end 1
END IF

dim as long iret1 = print2pdf(strptr(s_in),strptr(s_out), iflag, iforce)
end (iret1)
