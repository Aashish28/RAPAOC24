CLASS yzcl_console DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YZCL_CONSOLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  data it_prod type table of yztprod.

  DELETE FROM yztprod.

  it_prod = value #( ( productid = 1 productname = 'ParleG' baseprice = 2 currencycode = 'INR' uom = 'BAG' status = 'A' )
                   ( productid = 2 productname = 'Mariegold' baseprice = 3 currencycode = 'INR' uom = 'BAG' status = 'A' )
                   ( productid = 3 productname = 'Monaco' baseprice = 3 currencycode = 'INR' uom = 'BAG' status = 'A' )
                   ( productid = 4 productname = 'Hidenseek' baseprice = 7 currencycode = 'INR' uom = 'BAG' status = 'I' )
            ).

  insert yztprod from table @it_prod.

  ENDMETHOD.
ENDCLASS.
