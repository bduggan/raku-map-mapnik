use XML::Class;
unit module Mapnik;

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

=head1 SEE ALSO

https://github.com/mapnik/mapnik

=head1 AUTHOR

Brian Duggan (bduggan at matatu.org)

=end pod

