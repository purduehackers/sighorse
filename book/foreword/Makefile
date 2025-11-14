TYPST := typst

.PHONY: all
all: article

.PHONY: article
article: article.pdf

%.pdf: %.typ theme.typ
	$(TYPST) compile --font-path ./fonts $<
