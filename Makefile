all: index pdf

pdf: assets/cv.pdf
assets/cv.pdf: src/template/style.tex src/resume.md
	pandoc \
		--standalone \
		--template src/template/style.tex \
		--from markdown \
		--to context \
		-V papersize=A4 \
		-o assets/cv.tex \
		src/resume.md ; \
	sed -e \
		's/\\subsection\[title={Publications},reference={references}\]/\\startnegindent\n\\subsection\[title={Publications},reference={references}\]/g' \
		assets/cv.tex \
	| sed -e \
	's/\\thinrule/\\stopnegindent\n\\thinrule/g' \
	> assets/cv_mod.tex ;
	(cd assets && context cv_mod.tex --result=cv.pdf)

index: index.md
index.md: src/resume.md
	sed -n /^---$$/,/^---$$/p src/resume.md > index.md ; \
	pandoc --from markdown+definition_lists \
	--to markdown_phpextra+definition_lists \
	src/resume.md \
	| grep -v "\mybq" \
	>> index.md

clean:
	rm assets/cv.log
	rm assets/cv.pdf
	rm assets/cv.tex
	rm assets/cv.tuc
	rm assets/cv_mod.tex
	rm index.md