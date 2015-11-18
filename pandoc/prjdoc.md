# Call pandoc with prjdoc template

This first draft of the Pandoc template can't use metadata may provided by Pandoc. Instead, the additional fields of the LaTeX template must be passed as variables. So to call pandoc, the following options are needed:

* `--template=prjdoc.template` -- switch the template
* `-V 'mydocrev=R.4'` -- add the revision of the document
* `-V 'mydoctype=Spezification'` -- add the document type
* `-V 'mycompany=Foo Baa GmbH'` -- add the company name
* `-number-sections --toc` -- should be used... ;-)

