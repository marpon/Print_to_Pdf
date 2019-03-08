 /' test example to use libPrint2Pdf32.a or libPrint2Pdf64.a
	version 1.0 by marpon  08 March 2019
				contact marpon@aliceadsl.fr


	work in win10 with 'Microsoft Print To Pdf' virtual printer
		but much better because can be used in batch mode, without prompt for target file name

	but can also work stand-alone for differents file types
		raw text  as    	"txt", "log", "lst", "bas", "bi", "inc", "me",
							"c", "cpp", "h", "hpp", "cxx", "hxx", "inf",
							"bat" , "cmd" and even  ""   (ex for makefile)

		pictures  as		"bmp", "jpg", "jpeg", "png", "tiff", "gif"
				it will try to reproduce the 'real size' checking dimensions and dpi resolution
				and try also to best fit , so rotate 270° when needed.


 '/

'selection according 32/64
#ifdef __FB_64BIT__
	#INCLIB "Print2Pdf64"			' the lib name is  :  libPrint2Pdf64.a
#else
	#INCLIB "Print2Pdf32"			' the lib name is  :  libPrint2Pdf32.a
#endif

'the only needed declare function
extern "c"
	Declare Function print2pdf alias "print2pdf"( _
					Byval psrc as zstring ptr, _		'source file full path to convert to pdf
					Byval pdest as zstring ptr, _		'target file full path  , if null the source file will be used as path with .pdf
					byval verbose as long = 0) _		'verbose, by defaut not in verbose mode, show steps on console but also in gui mode (adding console)
					as long								'  returns 0 on success ;   <> 0 if fail
end extern


'usage
'==============================================================================


dim as string s_in = "D:\freebasic\print_pdf\malakoff_mederic.doc"
dim as string s_out = "D:\freebasic\print_pdf\malakoff_mederic_lib.pdf"


print "return = " &  print2pdf(strptr(s_in),strptr(s_out))		'notice here without verbose mode, no need for third argument
print : print

 s_in = "D:\freebasic\print_pdf\plan_dec.bmp"
s_out = "D:\freebasic\print_pdf\plan_fromlib.pdf"
print2pdf(strptr(s_in),strptr(s_out),1)					'notice here in verbose mode, third argument <>0



s_in = "D:\freebasic\print_pdf\malakoff_mederic.doc"
s_out = "D:\freebasic\print_pdf\malakoff_mederic_lib.pdf"
print2pdf(strptr(s_in),strptr(s_out),1)					'notice here in verbose mode, third argument <>0

