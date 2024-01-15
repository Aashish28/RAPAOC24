CLASS LHC_YI_SOITM DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      CALCULATEITEMUUID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  yi_soitm~CalculateItemUUID ,
      setItemNumber FOR DETERMINE ON SAVE
            IMPORTING keys FOR yi_soitm~setItemNumber,
      getItemPrice FOR DETERMINE ON MODIFY
            IMPORTING keys FOR yi_soitm~getItemPrice.

*      calculateTotalPrice FOR DETERMINE ON MODIFY
*            IMPORTING keys FOR yi_soitm~calculateTotalPrice.
ENDCLASS.

CLASS LHC_YI_SOITM IMPLEMENTATION.
  METHOD CALCULATEITEMUUID.
  ENDMETHOD.
  METHOD setItemNumber.
    DATA max_soitemnumber TYPE yztsoitm-soitem.
    DATA soitem_update TYPE TABLE FOR UPDATE YR_yi_sohdr01TP\\yi_soitm.

    "Read all travels for the requested bookings
    " If multiple bookings of the same travel are requested, the travel is returned only once.
    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_soitm BY \_yi_sohdr
        FIELDS ( SoID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_soid).

   " Process all affected travels. Read respective bookings for one travel
    LOOP AT lt_soid INTO DATA(ls_soid).
      READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
        ENTITY yi_sohdr BY \_yi_soitm
          FIELDS ( Soitem )
          WITH VALUE #( ( %tky = ls_soid-%tky ) )
        RESULT DATA(lt_soitem).

      data(max_soitem) = REDUCE i( init x = 0 FOR ls_item in lt_soitem WHERE ( Soitem <> '' ) NEXT x = x + 1 ).

      " find max used bookingID in all bookings of this travel
      LOOP AT lt_soitem INTO DATA(ls_soitem) WHERE Soitem IS INITIAL.
        "IF ls_soitem-Soitem is initial.
        "  ls_soitem-Soitem = 1.
        "else.
          max_soitem = max_soitem + 1.
          ls_soitem-Soitem = max_soitem.
        "ENDIF.

         APPEND VALUE #( %tky      = ls_soitem-%tky
                        soitem = ls_soitem-Soitem
                      ) TO soitem_update.

      ENDLOOP.

      ENDLOOP.

    " Provide a booking ID for all bookings that have none.
    MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_soitm
        UPDATE FIELDS ( Soitem )
        WITH soitem_update.


  ENDMETHOD.

  METHOD getItemPrice.

      READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_soitm
      FIELDS ( ProductID Quantity Price Currencycode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_soitem).

      LOOP AT lt_soitem ASSIGNING FIELD-SYMBOL(<fs_soitem>).
      SELECT SINGLE baseprice from yztprod
      WHERE productid = @<fs_soitem>-ProductID into @DATA(lv_baseprice).
        if sy-subrc <> 0.
            lv_baseprice = 0.
        endif.
        <fs_soitem>-price = <fs_soitem>-Quantity * lv_baseprice .
        <fs_soitem>-uom = <fs_soitem>-uom.
      ENDLOOP.


    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_soitm BY \_yi_sohdr
      FIELDS ( MainUUID Totalprice Currencycode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_sohdr).


    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_sohdr BY \_yi_soitm
      FIELDS ( ProductID Quantity Price Currencycode )
      WITH CORRESPONDING #( lt_sohdr )
      RESULT DATA(lt_soallitem).

      data lv_totalprice type yztsohdr-totalprice.
      data lv_currencycode type yztsohdr-currencycode.

      LOOP AT lt_soallitem into data(ls_soitem).
       READ table lt_soitem into data(ls_sosingleitem) WITH KEY ItemUUID = ls_soitem-ItemUUID.
       if sy-subrc = 0 .
           lv_totalprice = lv_totalprice + ls_sosingleitem-Price.
       else.
           lv_totalprice = lv_totalprice + ls_soitem-Price.
       endif.
       lv_currencycode = ls_soitem-Currencycode.
      ENDLOOP.

      LOOP AT lt_sohdr ASSIGNING FIELD-SYMBOL(<fs_sohdr>).
        <fs_sohdr>-totalprice = lv_totalprice.
        <fs_sohdr>-Currencycode = lv_currencycode.
      ENDLOOP.

     MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
       ENTITY yi_sohdr
         UPDATE FIELDS ( Totalprice Currencycode )
         WITH CORRESPONDING #( lt_sohdr )
       ENTITY yi_soitm
         UPDATE FIELDS ( price Currencycode )
         WITH CORRESPONDING #( lt_soitem ).
         .

*    MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
*       ENTITY yi_soitm
*         UPDATE FIELDS ( price Currencycode )
*         WITH CORRESPONDING #( lt_soitem ).


  ENDMETHOD.

*  METHOD calculateTotalPrice.

*    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
*      ENTITY yi_soitm BY \_yi_sohdr
*      FIELDS ( MainUUID Totalprice Currencycode )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_sohdr).
*
*
*    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
*      ENTITY yi_sohdr BY \_yi_soitm
*      FIELDS ( ProductID Quantity Price )
*      WITH CORRESPONDING #( lt_sohdr )
*      RESULT DATA(lt_soitem).
*
*      data lv_totalprice type yztsohdr-totalprice.
*      data lv_currencycode type yztsohdr-currencycode.
*
*      LOOP AT lt_soitem into data(ls_soitem).
*       lv_totalprice = lv_totalprice + ls_soitem-Price.
*       lv_currencycode = ls_soitem-Currencycode.
*      ENDLOOP.
*
*      LOOP AT lt_sohdr ASSIGNING FIELD-SYMBOL(<fs_sohdr>).
*        <fs_sohdr>-totalprice = lv_totalprice.
*        <fs_sohdr>-Currencycode = lv_currencycode.
*      ENDLOOP.
*
*     MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
*       ENTITY yi_sohdr
*         UPDATE FIELDS ( Totalprice Currencycode )
*         WITH CORRESPONDING #( lt_sohdr ).

*  ENDMETHOD.


ENDCLASS.
