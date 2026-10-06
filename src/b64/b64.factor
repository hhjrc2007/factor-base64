USING: grouping io io.encodings.binary io.files kernel math sequences ;
IN: b64

CONSTANT: alphabet
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

: bytes>n ( seq -- n ) 0 [ swap 8 shift bitor ] reduce ;
: 6bit>ch ( n -- ch ) alphabet nth ;
: n>6bits ( n -- seq ) { -18 -12 -6 0 } [ shift 63 bitand ] with map ;

: encode-group ( bytes -- str )
    [ 3 0 pad-tail bytes>n n>6bits [ 6bit>ch ] "" map-as ]
    [ length 1 + ] bi
    head 4 CHAR: = pad-tail ;

: >base64 ( bytes -- str ) 3 group [ encode-group ] map "" concat-as ;
: encode-file ( path -- ) binary file-contents >base64 print ;

: ch>6bit ( ch -- n ) alphabet index ;
: 6bits>n ( seq -- n ) 0 [ swap 6 shift bitor ] reduce ;

: n>bytes ( n -- bytes ) { -16 -8 0 } [ shift 255 bitand ] with B{ } map-as ;

: decode-group ( str -- bytes )
    [ CHAR: = = ] trim-tail
    [ 4 CHAR: A pad-tail [ ch>6bit ] { } map-as 6bits>n n>bytes ]
    [ length 1 - ] bi
    head ;

: main ( -- ) "README" encode-file ;

MAIN: main