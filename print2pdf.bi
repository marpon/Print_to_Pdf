'Print2Pdf.bi v: 1.4  21 March 2019     by Marpon   marpon@aliceadsl.fr

#Pragma Once


#Ifndef _PRINT2PDF_BI_
    #Define _PRINT2PDF_BI_

	#Include Once "windows.bi"
	#Include Once "win\winspool.bi"				 	 ' for default printer
	#Include Once "win\psapi.bi"                     ' for process
	#Include Once "win\shellapi.bi"                  ' for shellexecute
	#Include Once "file.bi"							 ' for fileexists
	#include once "win\tlhelp32.bi"     			 ' for extended process functions
	#INCLUDE ONCE "crt\stdio.bi"        			 ' for c io functions

	#Include Once "win\gdiplus.bi"					 ' for converting picture format to jpg and rotate

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

	'helper functions to work with all console states from lib
	Declare Function getParentPID(byval pid as DWORD) as DWORD
	Declare Function in_console(byval iset as long, byref stitle as string) as long
	Declare Sub restore_true_console(byval ppid as DWORD)
	Declare Function check_cmd()as long

	'helper functions to work with files/folders from lib
	Declare Function my_FullName(ByRef Src As String) As String
	Declare Function my_OnlyName(Byref Src As string) As String
	Declare Function FolderExists(byref sFolder as string) as long
	Declare Function my_Extension(ByRef Src As String) As String

	Declare Function lib2pdf_version()as short

	'the core declare functions from the lib, notice the extern "C", in fact part of the code is coming from c compiled .o file
	Extern "C"
		' the convert to pdf function
		Declare Function Print2Pdf Alias "print2pdf"( _
						Byval psrc As Zstring Ptr, _		'source file full path to convert to pdf
						Byval pdest As Zstring Ptr, _		'target file full path  , if null the source file will be used as path with .pdf
						byval verbose As Long = 0, _		'by defaut 0 not verbose,  if 1 shows errors with MessageBox ; if 2 debugg mode, shows steps to console (adding console if needed)
						byval overwrite As Long = 0) _		'by defaut 0 does not overwrite, if 1 ask question mode ,  else forces overwrite existing destination
						As Long								'  returns 0 on success ;   > 0      if fails : 1 to 13 see meaning under

		' to check if win10 and 'Microsoft Print to Pdf' available
		Declare Function checkfull Alias "checkfull"( _
						byval verbose As Long = 0) _        'by defaut not verbose , if <> 0 minimal verbose mode, shows info with MessageBox
						As Long								'  returns 0 on success ;   > 0       if fails : 1 or 2 see meaning under
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
6	Destination file already exists
7	Destination file already exists but decided not to replace it
8	Type file not convertible
9	Pdf source file, nothing to do
10	Using 'Microsoft Print to Pdf' error : Impossible to proceed
11	Using 'Microsoft Print to Pdf' error, probably : Type of file	does no have known application to print with
12  Using 'Microsoft Print to Pdf' error : internal execution problem (ShellExecute)
13  Using 'Microsoft Print to Pdf' error : internal execution problem, application to print with does not open
'/
