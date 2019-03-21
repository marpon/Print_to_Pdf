# Print_to_Pdf
static lib (for freebasic use) to work with 'Microsoft Print to Pdf' virtual printer in 32 and 64bits

And some sample code to work with.

Print2pdf.bas is the source to create  Print2Pdf.exe :   a cmd line tool to convert file to Pdf.

Win2Pdf.bas is the source file to create Win2Pdf.exe :   a GUI application to convert multiple files to Pdfs

A batch file to test launching print2pdf

The Print2Pdf.exe and Print2Pdf_64.exe, are the compiled exe for 32 and 64 bits,
given only for the ones who do not know how to use freebasic compiler.

Same for Win2Pdf.exe Win2Pdf_64.exe...


static libs version 1.4 by marpon  21 March 2019
				contact marpon@aliceadsl.fr
 
some brief information of features :


	work in win10 with 'Microsoft Print To Pdf' virtual printer
		but much better because can be used in batch mode, without prompt for target file name 
	
	but can also work stand-alone for differents file types
		raw text  as:   "txt", "log", "lst", "bas", "bi", "inc", "me", 
				 "c", "cpp", "h", "hpp", "cxx", "hxx", "inf",
				 "bat" , "cmd" and even  ""   (ex for makefile) and more raw text files
		
		pictures  as:	"bmp", "jpg", "jpeg", "png", "tiff", "gif"
				it will try to reproduce the 'real size' checking dimensions and dpi resolution
				and try also to best fit , so rotate 270° when needed.


