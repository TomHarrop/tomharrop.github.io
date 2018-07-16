all: html pdf

pdf: pdf/resume.pdf
pdf/resume.pdf: template/style.tex resume.md
	pandoc --standalone --template template/style.tex \
	--from markdown --to context \
	-V papersize=A4 -o pdf/resume.tex resume.md ; \
	src/label_reference_subsection.py pdf/resume.tex > pdf/resume_mod.tex
	context pdf/resume_mod.tex --result=pdf/resume.pdf

html: index.html
index.html: template/template.html5 css/flatly.css css/overrides.css resume.md
	pandoc --from markdown --to html5+smart \
		--css css/flatly.css --css css/overrides.css \
		--standalone --template template/template.html5 \
		-o index.html resume.md

clean:
	rm index.html
	rm pdf/resume.tex
	rm pdf/resume.tuc
	rm pdf/resume.log
	rm pdf/resume.pdf
	rm pdf/resume_mod.tex
