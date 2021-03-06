dummy:
	@echo No need to make anything.

ifdef VERSION
tag:
	@git update-index --refresh --unmerged
	@if git diff-index --name-only HEAD | grep ^ ; then \
		echo Uncommitted changes in above files; exit 1; fi
	sed 's/^\(my $$version = \).*/\1$(VERSION);/' -i get_iplayer
	@./get_iplayer --manpage get_iplayer.1; git add get_iplayer.1
	@git commit -m "Tag version $(VERSION)" get_iplayer get_iplayer.1
	@git tag v$(VERSION)

tarball:
	@git update-index --refresh --unmerged
	@if git diff-index --name-only v$(VERSION) | grep ^ ; then \
		echo Uncommitted changes in above files; exit 1; fi
	git archive --format=tar --prefix=get_iplayer-$(VERSION)/ v$(VERSION) | gzip -9 > get_iplayer-$(VERSION).tar.gz
endif
