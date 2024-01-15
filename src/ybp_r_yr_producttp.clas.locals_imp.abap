CLASS lsc_yr_yr_producttp DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_yr_yr_producttp IMPLEMENTATION.

  METHOD adjust_numbers.

   select max( productid ) from YI_YR_PRODUCT into @data(lv_max).

   loop at mapped-yr_product REFERENCE INTO data(map).
        lv_max = lv_max + 1.
        map->ProductID = lv_max.
   ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS LHC_YR_PRODUCT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR YR_PRODUCT
        RESULT result,
      setInitValue FOR DETERMINE ON MODIFY
            IMPORTING keys FOR YR_PRODUCT~setInitValue.
ENDCLASS.

CLASS LHC_YR_PRODUCT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD setInitValue.

*    READ ENTITIES OF YR_YR_PRODUCTTP IN LOCAL MODE
*    ENTITY yr_product ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT data(lt_product).

    MODIFY ENTITIES OF YR_YR_PRODUCTTP IN LOCAL MODE
    ENTITY yr_product UPDATE FIELDS ( Status )
    WITH VALUE #( FOR key IN keys (
        %tky = key-%tky
        Status = 'A'
    ) ).

  ENDMETHOD.

ENDCLASS.
