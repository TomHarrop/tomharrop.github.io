all: index pdf

pdf: pdf/resume.pdf
pdf/resume.pdf: template/style.tex resume.md
	pandoc --standalone --template template/style.tex \
	--from markdown --to context \
	-V papersize=A4 -o pdf/resume.tex resume.md ; \
	sed -e \
	's/\\subsection\[title={Publications},reference={references}\]/\\startnegindent\n\\subsection\[title={Publications},reference={references}\]/g' \
	pdf/resume.tex \
	| sed -e \
	's/\\thinrule/\\stopnegindent\n\\thinrule/g' \
	> pdf/resume_mod.tex ;
	(cd pdf && context resume_mod.tex --result=resume.pdf)

index: index.md
index.md: resume.md
	sed -n /^---$$/,/^---$$/p resume.md > index.md ; \
	pandoc --from markdown+definition_lists \
	--to markdown_phpextra+definition_lists \
	resume.md \
	| grep -v "\mybq" \
	>> index.md

clean:
	rm pdf/resume.tex
	rm pdf/resume.tuc
	rm pdf/resume.log
	rm pdf/resume.pdf
	rm pdf/resume_mod.tex
