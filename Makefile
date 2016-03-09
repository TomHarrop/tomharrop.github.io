all: html pdf docx rtf

pdf: pdf/resume.pdf
pdf/resume.pdf: resume.md
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume.md; \
	context resume.tex --result=pdf/resume.pdf

html: index.html
index.html: style_chmduquesne.css resume.md
	pandoc --from markdown --to html5 \
		--css css/bootstrap.css --css css/indents.css \
		--smart --standalone --template template.html5 \
		-o index.html resume.md


docx: resume.docx
resume.docx: resume.md
	pandoc -s -S resume.md -o resume.docx

rtf: resume.rtf
resume.rtf: resume.md
	pandoc -s -S resume.md -o resume.rtf

clean:
	rm index.html
	rm resume.tex
	rm pdf/resume.tuc
	rm pdf/resume.log
	rm pdf/resume.pdf
	rm resume.docx
	rm resume.rtf
