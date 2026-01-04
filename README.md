[![Actions Status](https://github.com/bduggan/raku-map-mapnik/actions/workflows/linux.yml/badge.svg)](https://github.com/bduggan/raku-map-mapnik/actions/workflows/linux.yml)
[![Actions Status](https://github.com/bduggan/raku-map-mapnik/actions/workflows/macos.yml/badge.svg)](https://github.com/bduggan/raku-map-mapnik/actions/workflows/macos.yml)

NAME
====

Map::Mapnik -- Generate XML for Mapnik

SYNOPSIS
========

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

DESCRIPTION
===========

This is a module for generating XML for the mapnik XML interface.

The syntax of this is described here: https://github.com/mapnik/mapnik/wiki/XMLConfigReference

The classes provided mirror the XML structure described there. Most of the work is done by [XML::Class](XML::Class), which provides the xml rendering based on class definitions.

SEE ALSO
========

https://github.com/mapnik/mapnik

[XML::Class](XML::Class)

AUTHOR
======

Brian Duggan (bduggan at matatu.org)

