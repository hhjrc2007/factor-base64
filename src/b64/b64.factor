USING: io kernel math sequences ;
IN: b64

CONSTANT: alphabet
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

: bytes>n ( seq -- n ) 0 [ swap 8 shift bitor ] reduce ;

: 6bit>ch ( n -- ch ) alphabet nth ;
: main ( -- ) "hello from b64" print ;

: n>6bits ( n -- seq ) { -18 -12 -6 0 } [ shift 63 bitand ] with map ;

MAIN: main
