\[DRAFT\] Haskell 2024 Language Report
--------------------------------------

This is a fork of the repository for the Haskell 2010 Language Report. The
original is preserved in locked branch `master`.

The purpose of the fork is to explore the creation of a 'Haskell 2024 Lanaguage 
Report': a report that corresponds to the Haskell 2010 Language Report, if the 
GHC language extensions in the `GHC2024` language edition were part of the 
language.

The document does not claim to be a definition of the languages Haskell 98 or
Haskell 2010.

Building the PDF and HTML report on Windows
-------------------------------------------

The MSYS2 project provides the `make` and `flex` tools, and
[Stack](https://docs.haskellstack.org/en/stable/) provides an MSYS2 environment.

Command:
~~~text
stack exec -- pacman --sync --needed make flex
~~~

The [MiKTex project](https://miktex.org/) provides a TeX distribution for
Windows.

The `make` tool can then be used by commanding:
~~~text
stack exec -- make
~~~

There is an important `README` file in the `report` directory.

GitHub Pages
------------

The `docs` directory in the `github-pages` branch is used to publish the HTML
report at https://mpilgrem.github.io/haskell-report/.

`index.html` redirects to `haskell.html`.

Haskell 2010 Language Report README
-----------------------------------
```
Haskell Report README
~~~~~~~~~~~~~~~~~~~~~

These are the sources to the Haskell report, including all the source
files you will need to generate either the PDF or the HTML version of
the report.


Tools you will need
~~~~~~~~~~~~~~~~~~~

PDF version: a decent LaTeX installation with pdflatex.  We use the
following additional packages:

  - times
  - makeidx
  - graphicx
  - url
  - color
  - hyperref

Also you need the following tools

  - makeindex

all of which are usually available with a good TeX distribution
(e.g. TeX Live).

The following are also required for building the tools:

  - flex
  - GHC

The HTML version additionally requires

  - tex4ht (e.g. install 'tex4ht' on a Debian or Ubuntu system, or
            'tetex-tex4ht' on a Fedora system)

Building the report
~~~~~~~~~~~~~~~~~~~

Firstly:

        $ cd tools
        $ make

should build a few tools required for building the report itself.
Then you should be able to say

        $ cd report
        $ make

This will create:

   - PDF version: report/haskell.pdf

   - HTML version: report/ht/haskell.html
     (NB. requires report/ht/*.{html,png,css})


Roadmap
~~~~~~~

SOURCE FILES

    report/		The Language and Libraries Reports (now together
			in a single document)

    tools/		Tools needed to build the Reports
		    	(cd into here and type make)

    Makefile		Build a distribution of the Reports


.verb files
~~~~~~~~~~~
```
