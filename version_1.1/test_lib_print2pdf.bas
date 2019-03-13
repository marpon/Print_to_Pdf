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

#include once "./print2pdf.bi"		' for pdf convertion : txt, pictures
									'  and more if exists 'Microsoft print to pdf' virtual printer



'usage
'==============================================================================


dim as string s_in = $"D:\freebasic\testlib\ms_word.doc"         'notice $ in front of string to avoid warning possible escape sequence on backslash
dim as string s_out = $"D:\freebasic\testlib\ms_word_doc.pdf"     ' or ! in front of string to say use escape sequence with \\ for backslash


print "return = " &  print2pdf(strptr(s_in),strptr(s_out), 1)		'notice here without verbose mode, no need for third argument
print : print

 s_in = $"D:\freebasic\testlib\plan.bmp"
s_out = $"D:\freebasic\testlib\plan_bmp.pdf"
print2pdf(strptr(s_in),strptr(s_out),1)					'notice here in verbose mode, third argument <>0,  if no console opens 1 console



s_in = $"D:\freebasic\testlib\penguin.jpg"
s_out = $"D:\freebasic\testlib\penguin_jpg.pdf"
print2pdf(strptr(s_in),strptr(s_out),1)					'notice here in verbose mode, third argument <>0,  if no console opens 1 console


s_in = $"D:\freebasic\testlib\blabla.txt"
s_out = $"D:\freebasic\testlib\blabla_txt.pdf"
print2pdf(strptr(s_in),strptr(s_out))					'notice here without verbose mode, no need for third argument
