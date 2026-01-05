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
    Mapnik::Layer.new(
      name => "world", :$srs,
      style-names => [
        Mapnik::StyleName.new( text => "My Style"),
      ],
      datasources => [
        Mapnik::Datasource.new: parameters =>  [
          Mapnik::Parameter.new( name => 'type', text => 'shape' ),
          Mapnik::Parameter.new: name => 'file', text => 'ne_110m_admin_0_countries.shp'
        ]
      ]
    )
  ],
;

$map.to-xml ==> spurt( "style.xml" );
shell q:to/SH/;
wget https://github.com/mapnik/mapnik/wiki/data/110m-admin-0-countries.zip
unzip 110m-admin-0-countries.zip
mapnik-render ./style.xml out.png
SH

