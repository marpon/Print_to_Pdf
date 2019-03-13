'print2pdf cmd line tool



#include once "./print2pdf.bi"		' for pdf convertion : txt, pictures
									'  and more if exists 'Microsoft print to pdf' virtual printer


sub help_usage()
	dim as string mess = chr(10,10)
	mess &=  "usage  :  Print2Pdf [option] ""Full_File_Path_for_File_to_Convert""  [""Full_File_Path_for_Pdf""]" & chr(10,10)
	mess &=  "          where option can be one of these options:" & chr(10)
	mess &=  "            -h  or --help      shows that usage" & chr(10)
	mess &=  "            -n  or --nothing   shows nothing even in error case" & chr(10)
	mess &=  "            -v  or --verbose   shows messagebox errors only" & chr(10)
	mess &=  "            -d  or --debugg    shows console messages of process" & chr(10,10)
	mess &=  "the only necessary argument is ""Full_File_Path_for_File_to_Convert""" & chr(10,10)
	MessageBox 0 ,  mess , "Print2pdf : usage!" , MB_SETFOREGROUND + MB_ICONWARNING
END SUB



dim as string s_in
dim as string s_out
dim as string ss1


Dim As long i = 1
dim as long iflag = 0
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

dim as long iret1 = print2pdf(strptr(s_in),strptr(s_out), iflag)
end (iret1)
