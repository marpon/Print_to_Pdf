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

#define _YOUR_PATH_TO_FILES_   "D:\freebasic\testlib\"			'notice $ in front of string to avoid warning possible escape sequence on backslash

dim as string s_in
dim as string s_out


'test if in windows10  and if 'Microsoft print to pdf' virtual printer available if 0 ok else not ok
dim as long iswin10pdf = checkfull(0)

if iswin10pdf = 0 THEN      'because ms_word document needs 'Microsoft print to pdf' virtual printer
	s_in =  _YOUR_PATH_TO_FILES_ & "ms_word.doc"
	s_out = _YOUR_PATH_TO_FILES_ & "ms_word_doc.pdf"     ' or ! in front of string to say use escape sequence with \\ for backslash
	print "try ms_word.doc = " &  print2pdf(strptr(s_in),strptr(s_out))		'notice here without verbose mode, no need for third argument
	print : print

END IF


'''  for the others tests  txt , bmp or jpg not needed 'Microsoft print to pdf' virtual printer
'''		the print2pff  works alone for raw text	 and some pictures format see comments a top of the file



s_in = _YOUR_PATH_TO_FILES_ & "plan.bmp"			'it will be ok the file exists
s_out = _YOUR_PATH_TO_FILES_ & "plan_bmp.pdf"
print "try plan.bmp = " & print2pdf(strptr(s_in),strptr(s_out),1)		'notice here in minimal verbose mode , third argument  = 1,  shows only errors via messagebox
print : print

 s_in = _YOUR_PATH_TO_FILES_ & "plan2.bmp"			'it will be wrong the file exists so messagebox info
s_out = _YOUR_PATH_TO_FILES_ & "plan2_bmp.pdf"
print "try plan2.bmp = " & print2pdf(strptr(s_in),strptr(s_out),2)		'notice here in debugg mode , third argument  = 2,  if no console, opens 1 console
print : print

s_in = _YOUR_PATH_TO_FILES_ & "penguin.jpg"
s_out =_YOUR_PATH_TO_FILES_ & "penguin_jpg.pdf"
print "try penguin.jpg = " & print2pdf(strptr(s_in),strptr(s_out),1)	'notice here in minimal verbose mode , third argument  = 1,  shows only errors via messagebox
print : print

s_in = _YOUR_PATH_TO_FILES_ & "blabla.txt"
s_out = _YOUR_PATH_TO_FILES_ & "blabla_txt.pdf"
print "try blabla.txt = " & print2pdf(strptr(s_in),strptr(s_out),2)		'notice here in debugg mode , third argument  = 2,  if no console, opens 1 console
print : print