#Pragma Once


#Ifndef _PRINT2PDF_BI_
    #Define _PRINT2PDF_BI_

	#Include Once "windows.bi"
	#Include Once "win\winspool.bi"				 	 ' for default printer
	#Include Once "win\psapi.bi"                     ' for process
	#Include Once "win/shellapi.bi"                  ' for shellexecute
	#Include Once "file.bi"							 ' for fileexists

	#Include Once "win/gdiplus.bi"					 ' for converting picture format to jpg and rotate

	Using gdiplus

	Extern "Windows" Lib "ntdll"
		Declare Function RtlGetVersion Alias "RtlGetVersion"(byref OsVerInfoEx AS OSVERSIONINFOEXW) As Long
	End Extern

	'selection according 32/64
	#Ifdef __FB_64BIT__
		#INCLIB "Print2Pdf_64"			' the lib name is  :  libPrint2Pdf_64.a
	#Else
		#INCLIB "Print2Pdf_32"			' the lib name is  :  libPrint2Pdf_32.a
	#Endif


	'the only needed declare function from the lib
	Extern "C"
		Declare Function Print2Pdf Alias "print2pdf"( _
						Byval psrc As Zstring Ptr, _		'source file full path to convert to pdf
						Byval pdest As Zstring Ptr, _		'target file full path  , if null the source file will be used as path with .pdf
						byval verbose As Long = 0) _		'verbose, by defaut not in verbose mode, show steps on console but also in gui mode (adding console)
						As Long								'  returns 0 on success ;   <> 0 if fail
	End Extern

#Endif

