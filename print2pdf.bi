'Print2Pdf.bi v: 1.2

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


	'the only needed declare functions from the lib
	Extern "C"
		' the convert to pdf function
		Declare Function Print2Pdf Alias "print2pdf"( _
						Byval psrc As Zstring Ptr, _		'source file full path to convert to pdf
						Byval pdest As Zstring Ptr, _		'target file full path  , if null the source file will be used as path with .pdf
						byval verbose As Long = 0) _		'by defaut not verbose,  if 1 shows errors with MessageBox ; if 2 debugg mode, shows steps to console (adding console if needed)
						As Long					'  returns 0 on success ;   > 0     if fails : 1 to 13 see meaning under

		' to check if win10 and 'Microsoft Print to Pdf' available
		Declare Function checkfull Alias "checkfull"( _
						byval verbose As Long = 0) _        'by defaut not verbose , if <> 0 minimal verbose mode, shows info with MessageBox
						As Long					'  returns 0 on success ;   > 0      if fails : 1 or 2 see meaning under
	End Extern

#Endif

/'
returned  message code meaning
0	Ok
1	windows version < 10  so 'Microsoft Print to Pdf' virtual printer not be possible ,  only raw txt and bmp; jpg ; jpeg; gif; png; tif will work
2	'Microsoft Print to Pdf' virtual printer not installed , 							 only raw txt and bmp; jpg ; jpeg; gif; png; tif will work
3	No defined file to convert to pdf
4	Wrong Source file full path
5	Given destination folder does not exist
10	Using 'Microsoft Print to Pdf' error : Impossible to proceed
11	Using 'Microsoft Print to Pdf' error, probably : Type of file	does no have known application to print with
12  Using 'Microsoft Print to Pdf' error : internal execution problem (ShellExecute)
13  Using 'Microsoft Print to Pdf' error : internal execution problem, application to print with does not open
'/
