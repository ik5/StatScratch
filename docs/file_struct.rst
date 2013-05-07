==============
File Structure
==============

The following document is an attempt to create some sort of specification on how the content file works.
This file may change according to development, but display the idea and the state of mind behind the implementation

:VERSION: 0.1

---------------
File Attributes
---------------
File name is the same as the file that will be generated, as .erb file at the end.
for example "file_struct.rst" will be generated into "file_struct.html.erb".
Then the erb template will generate a normal html output as file_struct.html at the proper directory.

*File extensions are the type of content inside*, and supported files are:
  - rst         - reStructuredText_

:TODO:
   - md/markdown - Markdown_
   - textile     - Textile_
   - mw          - MediaWiki_
   - tex         - LaTeX_

--------------------
Variables to be used
--------------------
:lang:
   The `iso code`_ of the language that the content is for.
   "en" for English, "he" for Hebrew etc...


.. _Markdown: http://daringfireball.net/projects/markdown/
.. _reStructuredText: http://docutils.sourceforge.net/docs/ref/rst/introduction.html
.. _Textile: http://redcloth.org/textile
.. _MediaWiki: http://www.mediawiki.org/wiki/Help:Formatting
.. _LaTeX: http://www.latex-project.org
.. _iso code: http://en.wikipedia.org/wiki/ISO_639
