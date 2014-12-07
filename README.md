
# Diagram Tools

A number of small tools for generating and manipulating diagrams, mostly
relying on Graphviz for output.

Vidar Hokstad &lt;vidar@hokstad.com>

Unless otherwise noted, everything here is under the MIT license - see
the LICENSE file.

## notugly.xsl ##

[An XSL transform to pretty up the SVG output from Graphviz](http://www.hokstad.com/making-graphviz-output-pretty-with-xsl.html); 
see also [this update](http://www.hokstad.com/making-graphviz-output-pretty-with-xsl-updated.html)

By Vidar Hokstad and Ryan Shea; Contributions by Jonas Tingborn, Earl Cummings, 
Michael Kennedy (Graphviz 2.20.2 compatibility, bug fixes,
testing, lots of gradients); Paul Boddie (refactoring, bug fixes)

Example output:

![expected output](https://raw.githubusercontent.com/vidarh/diagram-tools/master/tests/test-notugly-expected.svg)

## arytodot.rb ##

[A script by Vidar Hokstad to visualize Ruby arrays using Graphviz](http://www.hokstad.com/creating-graphviz-graphs-from-ruby-arrays.html)

## traceviz.rb ##

[A script by Vidar Hokstad to visualize traceroute ouput with Graphviz](http://www.hokstad.com/traceviz-visualizing-traceroute-output-with-graphivz.html)
