CLASS LHC_YI_SOHDR DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR yi_sohdr
        RESULT result,
      CALCULATEMAINUUID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  yi_sohdr~CalculateMainUUID ,
      precheck_create FOR PRECHECK
            IMPORTING entities FOR CREATE yi_sohdr,
      setInitValues FOR DETERMINE ON MODIFY
            IMPORTING keys FOR yi_sohdr~setInitValues,
      checkDeliveryDate FOR VALIDATE ON SAVE
            IMPORTING keys FOR yi_sohdr~checkDeliveryDate,
      setStatusInprocess FOR MODIFY
            IMPORTING keys FOR ACTION yi_sohdr~setStatusInprocess RESULT result,
      setStatus FOR MODIFY
            IMPORTING keys FOR ACTION yi_sohdr~setStatus,
      setStatusDelivered FOR MODIFY
            IMPORTING keys FOR ACTION yi_sohdr~setStatusDelivered RESULT result,
      setStatusCancel FOR MODIFY
            IMPORTING keys FOR ACTION yi_sohdr~setStatusCancel RESULT result,
      get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR yi_sohdr RESULT result,
      uploaditems FOR MODIFY
            IMPORTING keys FOR ACTION yi_sohdr~uploaditems RESULT result.
ENDCLASS.

CLASS LHC_YI_SOHDR IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD CALCULATEMAINUUID.
  READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
    ENTITY yi_sohdr
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE MainUUID IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( MAINUUID ) FROM YZTSOHDR INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM YYI_SOHDR00D FIELDS MAX( MainUUID ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
    ENTITY yi_sohdr
      UPDATE FIELDS ( MainUUID )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        MainUUID     = max_object_id + i
  ) ).
  ENDMETHOD.

  METHOD precheck_create.



  ENDMETHOD.

  METHOD setInitValues.

  "Dummy logic to determine object_id
  SELECT MAX( soid ) FROM YZTSOHDR INTO @DATA(max_order_id).

    if max_order_id is initial.
        max_order_id = 1.
    else.
        max_order_id = max_order_id + 1.
    endif.

    MODIFY ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
    ENTITY yi_sohdr
      UPDATE FIELDS ( SoID Status Orderdate )
        WITH VALUE #( FOR key IN keys INDEX INTO i (
        %tky          = key-%tky
        SoID       = max_order_id
        Status     = 'N'
        Orderdate  = cl_abap_context_info=>get_system_date( )
  ) ).


  ENDMETHOD.

  METHOD checkDeliveryDate.

  READ ENTITIES OF YR_yi_sohdr01TP in LOCAL MODE
  ENTITY yi_sohdr ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_so).

  LOOP at lt_so ASSIGNING FIELD-SYMBOL(<fs_so>).
    if <fs_so>-Deliverydate is not initial and
        <fs_so>-Deliverydate < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky = <fs_so>-%tky )
                     TO failed-yi_sohdr.
                "Set message
        APPEND VALUE #( %tky = <fs_so>-%tky
                                %msg = new_message( id       = 'YMC_SO'
                                                    number   = 001
                                                    severity = if_abap_behv_message=>severity-error
                                                    v1       = |{ <fs_so>-Deliverydate } |
                                                   )
                                %element-deliverydate = if_abap_behv=>mk-on
                                )
                       TO reported-yi_sohdr.
                RETURN.

    endif.

  ENDLOOP.

  ENDMETHOD.

  METHOD setStatusInprocess.

  MODIFY ENTITIES OF YR_yi_sohdr01TP in LOCAL MODE
  ENTITY yi_sohdr
  EXECUTE setStatus FROM VALUE #( FOR key IN keys INDEX INTO i (
        %tky          = key-%tky
        %param-status = 'I'
        %param-comments = 'test'
  ) ).
"  FROM CORRESPONDING #( keys ).

"Read changed data for action result
    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_sohdr
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(lt_so).

    result = VALUE #( FOR ls_so IN lt_so ( %tky   = ls_so-%tky
                                           %param = ls_so ) ).

  ENDMETHOD.

  METHOD setStatus.

      MODIFY ENTITIES OF YR_yi_sohdr01TP in LOCAL MODE
      ENTITY yi_sohdr
      UPDATE FIELDS ( Status ) WITH VALUE #( FOR key IN keys INDEX INTO i (
            %tky          = key-%tky
            Status     = key-%param-status
      ) ).

  ENDMETHOD.

  METHOD setStatusDelivered.
      MODIFY ENTITIES OF YR_yi_sohdr01TP in LOCAL MODE
      ENTITY yi_sohdr
      EXECUTE setStatus FROM VALUE #( FOR key IN keys INDEX INTO i (
            %tky          = key-%tky
            %param-status = 'D'
            %param-comments = 'delivered'
      ) ).

"Read changed data for action result
    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
      ENTITY yi_sohdr
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(lt_so).

    result = VALUE #( FOR ls_so IN lt_so ( %tky   = ls_so-%tky
                                           %param = ls_so ) ).

  ENDMETHOD.

  METHOD setStatusCancel.

     MODIFY ENTITIES OF YR_yi_sohdr01TP in LOCAL MODE
          ENTITY yi_sohdr
          EXECUTE setStatus FROM VALUE #( FOR key IN keys INDEX INTO i (
                %tky          = key-%tky
                %param-status = 'C'
                %param-comments = key-%param-comments
          ) ).

    "Read changed data for action result
        READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
          ENTITY yi_sohdr
            ALL FIELDS WITH
            CORRESPONDING #( keys )
          RESULT DATA(lt_so).

        result = VALUE #( FOR ls_so IN lt_so ( %tky   = ls_so-%tky
                                               %param = ls_so ) ).
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF YR_yi_sohdr01TP IN LOCAL MODE
    ENTITY yi_sohdr
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_so).

    result = value #( FOR ls_so IN lt_so (
                      %tky = ls_so-%tky
                      %action-setStatusCancel = COND #( when ls_so-Status = 'D' then if_abap_behv=>fc-o-disabled
                                                        else if_abap_behv=>fc-o-enabled )
                      %action-setStatusDelivered = COND #( when ls_so-Status = 'C' then if_abap_behv=>fc-o-disabled
                                                        else if_abap_behv=>fc-o-enabled )
                      %action-setStatusInprocess = COND #( when ls_so-Status = 'C' then if_abap_behv=>fc-o-disabled
                                                        else if_abap_behv=>fc-o-enabled )
                    )
    ).

  ENDMETHOD.

  METHOD uploaditems.

  DATA :  lo_ref_data          TYPE REF TO data,
          lo_struct_typ        TYPE REF TO  cl_abap_datadescr,
          lo_dyntable_typ      TYPE REF TO  cl_abap_tabledescr,
          ls_component         TYPE cl_abap_structdescr=>component,
          lt_component         TYPE cl_abap_structdescr=>component_table.

  ENDMETHOD.

ENDCLASS.
