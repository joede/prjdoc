# Call pandoc with prjdoc template

This second draft of the Pandoc template. To pass the special prjdoc variables
to the template, you can use the YAML header supported by Pandoc. So the only
parameter tha must be passed to Pandoc are:

* `--template=prjdoc.latex` -- switch the template
* `--number-sections --toc` -- should be used... ;-)

The YAML should include the following fields. The entries starting with `PD`*
are related to prjdoc.

~~~~
---
title:      Sample showing YAML fields
author:     Winnie Pooh
PDrevision: R1
PDdoctype:  Just a simple sample
PDcompany:  Pooh's honey fab
---
~~~~
