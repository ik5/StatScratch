============
StatScratch
============
The following project is an attempt to scratch an itch of mine:

  - Creating static web site, 
  - Providing dynamic and static routes 
  - Control the difference between draft to check and published materials
  - Working with different structured markups, based on file, rather then 
    project
  - Multilingual support
  - Multiple template support
  - Inline and general configuration for the project

All of the existed static generators are either to specific for a task 
(blogs for example), or too complex to master, for small web sites.

So I have an itch, and this is my scratch

------------
Requirements
------------

  - Linux distro
  - Pandoc_.
  - Ruby 1.9.3/2.0
  - Bundler
  - A lot of good will and happy thoughts

--------
Defaults
--------
The project arrive with default static files (located under the static folder):
  - Default layout template named default.html.erb
  - html5-boilerplate css files
  - Dojo 1.9.0 - core files
  - normalize.css for normalizing html5
  - normalize-rtl.css for normalizing html5 with bi-directional languages
  - modernizr-2.6.2 - for making old browsers support html5 sections
 
-------------
Documentation
-------------
The project documentation located under the docs directory, and provide 
information about draft structure, including variables, separators and more.

You can find more information on directory structure, usage and more on that 
directory.

-------
License
-------
This whole projects and it's content is under the MIT license, unless mentioned 
otherwise inside a specific file.

Copyright (c) 2013 ik <idokan@gmail.com>

.. _Pandoc: http://johnmacfarlane.net/pandoc/
