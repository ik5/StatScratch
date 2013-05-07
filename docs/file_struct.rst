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


------------
File content
------------
One file can handle more then one language. It set on it's own section.

Each section will be set using special char combinations from the *beginning*
of the line.

The separator is four colons, space and four minus:
``:::: ----``

Each variable is set specifically to a language, and it is not global.

Beside the variable, and separator, everything else depends on the markup language itself.

   
--------------------
Variables to be used
--------------------

Variables are set by four colons at the beginning of a line, without space 
prior to them, then the variable name, then four more colons.
``::::lang::::``

After the four last colons, there will be *one* space data will arrive:
``::::lang:::: en``

**Supported variables:**

:lang:
   **Mandatory**. The `iso code`_ of the language that the content is for.
   "en" for English, "he" for Hebrew etc...

:path:
   **Mandatory**. The path the generated file should be.
   /en/about/

:title:
   The page title to be used at the head title

:template:
    If set, can specify what is the template to use. Otherwise it will use the 
    default template.

:file:
   If set, forces the name of the output file. Use it without the extension, only the name itself.
   **Note:** Will override existed file in that name and path.

:draft:
   Default - true. If set to false, the content will be publish.

:description:
   If set, places a description metadata to the template (if it exists).
 
:css:
   Separated by pipes ("|"), if set with full load path, can load custom css 
   files.

:js:
  Separated by pipes ("|"), if set with full load path, can load custom 
  javascript files.



:TODO:
  - Add more supported variables
  - Create ability to override existed css files
  - Create ability to override existed javascript files
 


.. _Markdown: http://daringfireball.net/projects/markdown/
.. _reStructuredText: http://docutils.sourceforge.net/docs/ref/rst/introduction.html
.. _Textile: http://redcloth.org/textile
.. _MediaWiki: http://www.mediawiki.org/wiki/Help:Formatting
.. _LaTeX: http://www.latex-project.org
.. _iso code: http://en.wikipedia.org/wiki/ISO_639
