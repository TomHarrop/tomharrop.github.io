all: html pdf

pdf: pdf/resume.pdf
pdf/resume.pdf: template/style_chmduquesne.tex resume.md
	pandoc --standalone --template template/style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume.md; \
	src/label_reference_subsection.py resume.tex > pdf/resume.tex
	context pdf/resume.tex --result=pdf/resume.pdf

html: index.html
index.html: template/template.html5 css/flatly.css css/overrides.css resume.md
	pandoc --from markdown --to html5 \
		--css css/flatly.css --css css/overrides.css \
		--smart --standalone --template template/template.html5 \
		-o index.html resume.md

# docx: resume.docx
# resume.docx: resume.md
# 	pandoc -s -S resume.md -o resume.docx

# rtf: resume.rtf
# resume.rtf: resume.md
# 	pandoc -s -S resume.md -o resume.rtf

clean:
	rm index.html
	rm resume.tex
	rm pdf/resume.tuc
	rm pdf/resume.log
	rm pdf/resume.tex
	rm pdf/resume.pdf
#	rm resume.docx
#	rm resume.rtf
