use XML::Class;
unit module Mapnik;

# https://get-map.org/mapnik-lost-manual/book/_font.html
class Font does XML::Class[xml-element => 'Font'] {
    has Str $.face-name is xml-attribute;                          # font face name
}

# https://get-map.org/mapnik-lost-manual/book/_fontset.html
class FontSet does XML::Class[xml-element => 'FontSet'] {
    has Str $.name is xml-attribute;                               # fontset identifier
    has Font @.fonts;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#datasource
class Parameter does XML::Class[xml-element => 'Parameter'] {
    has Str $.name is xml-attribute;
    has Str $.text is xml-simple-content;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#datasource
class Datasource does XML::Class[xml-element => 'Datasource'] {
    has Str $.name is xml-attribute is xml-skip-null;                  # create a datasource template
    has Str $.base is xml-attribute is xml-skip-null;                  # inherit from a datasource template
    has Parameter @.parameters;
}

# https://github.com/mapnik/mapnik/wiki/PolygonSymbolizer
class PolygonSymbolizer does XML::Class[xml-element => 'PolygonSymbolizer'] {
    has Str $.fill is xml-attribute is xml-skip-null;              # default: grey
    has Rat $.fill-opacity is xml-attribute is xml-skip-null;      # default: 1.0
    has Rat $.gamma is xml-attribute is xml-skip-null;             # default: 1.0
}

# https://github.com/mapnik/mapnik/wiki/LineSymbolizer
class LineSymbolizer does XML::Class[xml-element => 'LineSymbolizer'] {
    has Str $.stroke is xml-attribute is xml-skip-null;            # default: black
    has Rat $.stroke-width is xml-attribute is xml-skip-null;      # default: 1.0
    has Rat $.stroke-opacity is xml-attribute is xml-skip-null;    # default: 1.0
    has Str $.stroke-linejoin is xml-attribute is xml-skip-null;   # default: miter
    has Str $.stroke-linecap is xml-attribute is xml-skip-null;    # default: butt
    has Str $.stroke-dasharray is xml-attribute is xml-skip-null;  # default: none
}

# https://github.com/mapnik/mapnik/wiki/PointSymbolizer
class PointSymbolizer does XML::Class[xml-element => 'PointSymbolizer'] {
    has Str $.file is xml-attribute is xml-skip-null;
    has Str $.allow-overlap is xml-attribute is xml-skip-null;     # default: false
    has Rat $.opacity is xml-attribute is xml-skip-null;           # default: 1.0
    has Str $.transform is xml-attribute is xml-skip-null;
    has Str $.ignore-placement is xml-attribute is xml-skip-null;  # default: false
    has Str $.comp-op is xml-attribute is xml-skip-null;
}

# https://github.com/mapnik/mapnik/wiki/TextSymbolizer
class TextSymbolizer does XML::Class[xml-element => 'TextSymbolizer'] {
    has Str $.text is xml-simple-content;                                  # field name for text (e.g., "[name]")
    has Str $.face-name is xml-attribute is xml-skip-null;                 # font face name
    has Str $.fontset-name is xml-attribute is xml-skip-null;              # fontset name
    has Int $.size is xml-attribute is xml-skip-null;                      # font size, default: 10
    has Str $.fill is xml-attribute is xml-skip-null;                      # text color, default: black
    has Rat $.opacity is xml-attribute is xml-skip-null;                   # text opacity, default: 1.0
    has Str $.halo-fill is xml-attribute is xml-skip-null;                 # halo color
    has Rat $.halo-radius is xml-attribute is xml-skip-null;               # halo size, default: 0
    has Str $.halo-comp-op is xml-attribute is xml-skip-null;              # halo composite operation
    has Str $.placement is xml-attribute is xml-skip-null;                 # point, line, vertex, interior, default: point
    has Rat $.dx is xml-attribute is xml-skip-null;                        # horizontal offset, default: 0
    has Rat $.dy is xml-attribute is xml-skip-null;                        # vertical offset, default: 0
    has Str $.horizontal-alignment is xml-attribute is xml-skip-null;      # left, middle, right, auto
    has Str $.vertical-alignment is xml-attribute is xml-skip-null;        # top, middle, bottom, auto
    has Str $.justify-alignment is xml-attribute is xml-skip-null;         # left, center, right, auto
    has Rat $.text-ratio is xml-attribute is xml-skip-null;                # height to width ratio, default: 0
    has Int $.wrap-width is xml-attribute is xml-skip-null;                # text wrapping width, default: 0
    has Str $.wrap-before is xml-attribute is xml-skip-null;               # wrap before wrap-width, default: false
    has Str $.wrap-character is xml-attribute is xml-skip-null;            # character to use for wrapping
    has Rat $.orientation is xml-attribute is xml-skip-null;               # rotate text, default: 0
    has Str $.rotate-displacement is xml-attribute is xml-skip-null;       # rotate displacement, default: false
    has Int $.character-spacing is xml-attribute is xml-skip-null;         # additional horizontal spacing, default: 0
    has Int $.line-spacing is xml-attribute is xml-skip-null;              # vertical spacing between lines, default: 0
    has Str $.text-transform is xml-attribute is xml-skip-null;            # none, uppercase, lowercase, capitalize
    has Str $.allow-overlap is xml-attribute is xml-skip-null;             # default: false
    has Str $.avoid-edges is xml-attribute is xml-skip-null;               # default: false
    has Int $.margin is xml-attribute is xml-skip-null;                    # minimum distance from other labels, default: 0
    has Int $.repeat-distance is xml-attribute is xml-skip-null;           # minimum distance between repeated labels, default: 0
    has Int $.minimum-padding is xml-attribute is xml-skip-null;           # prevent placement near edge, default: 0
    has Int $.minimum-path-length is xml-attribute is xml-skip-null;       # minimum path length for placement, default: 0
    has Int $.spacing is xml-attribute is xml-skip-null;                   # space between repeated labels, default: 0
    has Str $.clip is xml-attribute is xml-skip-null;                      # clip geometry to view, default: true
    has Str $.largest-bbox-only is xml-attribute is xml-skip-null;         # label only largest polygon, default: true
    has Str $.placement-type is xml-attribute is xml-skip-null;            # dummy, simple, list
    has Str $.placements is xml-attribute is xml-skip-null;                # placement positions string
    has Str $.upright is xml-attribute is xml-skip-null;                   # left, right, auto, left_only, right_only
    has Str $.comp-op is xml-attribute is xml-skip-null;                   # composite operation
}

# https://github.com/mapnik/mapnik/wiki/Filter
class Filter does XML::Class[xml-element => 'Filter'] {
    has Str $.text is xml-simple-content;
}

# https://github.com/mapnik/mapnik/wiki/ElseFilter
class ElseFilter does XML::Class[xml-element => 'ElseFilter'] {
}

# https://github.com/mapnik/mapnik/wiki/MinScaleDenominator
class MinScaleDenominator does XML::Class[xml-element => 'MinScaleDenominator'] {
    has Int $.text is xml-simple-content;
}

# https://github.com/mapnik/mapnik/wiki/MaxScaleDenominator
class MaxScaleDenominator does XML::Class[xml-element => 'MaxScaleDenominator'] {
    has Int $.text is xml-simple-content;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#rule
class Rule does XML::Class[xml-element => 'Rule'] {
    has Str $.name is xml-attribute is xml-skip-null;              # optional
    has Str $.title is xml-attribute is xml-skip-null;             # optional
    has MinScaleDenominator $.min-scale-denominator is xml-skip-null;  # optional
    has MaxScaleDenominator $.max-scale-denominator is xml-skip-null;  # optional
    has Filter $.filter is xml-skip-null;                          # optional
    has ElseFilter $.else-filter is xml-skip-null;                 # optional
    has PointSymbolizer @.point-symbolizers;
    has PolygonSymbolizer @.polygon-symbolizers;
    has LineSymbolizer @.line-symbolizers;
    has TextSymbolizer @.text-symbolizers;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#style
class Style does XML::Class[xml-element => 'Style'] {
    has Str $.filter-mode is xml-attribute is xml-skip-null;
    has Str $.name is xml-attribute is xml-skip-null;
    has Rat $.opacity is xml-attribute is xml-skip-null;
    has Rule @.rules;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#layer
class StyleName does XML::Class[xml-element => 'StyleName'] {
    has Str $.text is xml-simple-content;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#layer
class Layer does XML::Class[xml-element => 'Layer'] {
    has Str $.abstract is xml-attribute is xml-skip-null;              # default: ""
    has Str $.cache-features is xml-attribute is xml-skip-null;        # default: "off"
    has Str $.clear-label-cache is xml-attribute is xml-skip-null;     # default: "off"
    has Rat $.minzoom is xml-attribute is xml-skip-null;               # default: 0.0
    has Rat $.maxzoom is xml-attribute is xml-skip-null;               # default: 1.797693134862316e+308
    has Str $.name is xml-attribute is xml-skip-null;
    has Str $.srs is xml-attribute is xml-skip-null;                   # default: inherits from Map.srs
    has Str $.status is xml-attribute is xml-skip-null;                # default: "on"
    has Str $.title is xml-attribute is xml-skip-null;                 # default: ""
    has Str $.queryable is xml-attribute is xml-skip-null;             # default: "false"
    has StyleName @.style-names;
    has Datasource @.datasources;
}

# https://github.com/mapnik/mapnik/wiki/XMLConfigReference#map
class Map does XML::Class[xml-element => 'Map'] {
    has Str $.background-color is xml-attribute is xml-skip-null;
    has Str $.background-image is xml-attribute is xml-skip-null;
    has Int $.buffer-size is xml-attribute is xml-skip-null;        # default: 0
    has Str $.font-directory is xml-attribute is xml-skip-null;
    has Str $.maximum-extent is xml-attribute is xml-skip-null;
    has Str $.minimum-version is xml-attribute is xml-skip-null;
    has Bool $.paths-from-xml is xml-attribute is xml-skip-null;    # default: true
    has Str $.srs is xml-attribute is xml-skip-null;
    has FontSet @.fontsets;
    has Style @.styles;
    has Layer @.layers;
}

=begin pod

=head1 NAME

Map::Mapnik -- Generate XML for Mapnik

=head1 SYNOPSIS

=begin code

# example from https://github.com/mapnik/mapnik/wiki/GettingStartedInXML

use Map::Mapnik;

my $srs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs";
my $map = Mapnik::Map.new:
  background-color => 'steelblue', :$srs,
  styles => [
    Mapnik::Style.new: name => "My Style", rules => 
       Mapnik::Rule.new:
         polygon-symbolizers => [ Mapnik::PolygonSymbolizer.new: fill => '#f2eff9' ],
         line-symbolizers => [ Mapnik::LineSymbolizer.new: stroke => 'rgb(50%,50%,50%)', stroke-width => 0.1 ],
     ],
  layers => [
    Mapnik::Layer.new: name => "world", :$srs,
    style-names => [
      Mapnik::StyleName.new( text => "My Style"),
    ],
    datasources => [
      Mapnik::Datasource.new: parameters =>  [
        Mapnik::Parameter.new( name => 'type', text => 'shape' ),
        Mapnik::Parameter.new: name => 'file', text => 'ne_110m_admin_0_countries.shp'
      ]
    ]
  ],
;

$map.to-xml ==> spurt( "style.xml" );
shell q:to/SH/;
wget https://github.com/mapnik/mapnik/wiki/data/110m-admin-0-countries.zip
unzip 110m-admin-0-countries.zip
mapnik-render ./style.xml out.png
SH

=end code

=head1 DESCRIPTION

This is a module for generating XML for the mapnik XML interface.

The syntax of this is described here: https://github.com/mapnik/mapnik/wiki/XMLConfigReference

The classes provided mirror the XML structure described there.  Most of the work
is done by L<XML::Class>, which provides the xml rendering based on class definitions.

=head1 SEE ALSO

https://github.com/mapnik/mapnik

L<XML::Class>

=head1 AUTHOR

Brian Duggan (bduggan at matatu.org)

=end pod

