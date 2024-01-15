CLASS lcl_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
        INCLUDE TYPE   yztstatus AS data.
    TYPES: flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tt_status TYPE SORTED TABLE OF ty_buffer WITH UNIQUE KEY statusid status.

    CLASS-DATA mt_buffer TYPE tt_status.
ENDCLASS.


CLASS LHC_ALLSTATUS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR allstatus
        RESULT result,
      CREATE FOR MODIFY
        IMPORTING
          ENTITIES FOR CREATE  allstatus,
      UPDATE FOR MODIFY
        IMPORTING
          ENTITIES FOR UPDATE  allstatus,
      DELETE FOR MODIFY
        IMPORTING
          KEYS FOR DELETE  allstatus,
      LOCK FOR LOCK
        IMPORTING
          KEYS FOR LOCK  allstatus,
      READ FOR READ
        IMPORTING
          KEYS FOR READ  allstatus
        RESULT result.
ENDCLASS.

CLASS LHC_ALLSTATUS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CREATE.
   DATA : ls_status TYPE yztstatus.

  LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

    ls_status = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
    INSERT VALUE #( flag = 'C' data = CORRESPONDING #( ls_status ) ) INTO TABLE lcl_buffer=>mt_buffer.

    mapped-allstatus = VALUE #( BASE mapped-allstatus
                       ( %cid = <entity>-%cid
                         StatusID = ls_status-statusid
                         Status = ls_status-status
                       ) ).

  ENDLOOP.

  ENDMETHOD.
  METHOD UPDATE.
  DATA : ls_status TYPE yztstatus.
  LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

    ls_status = CORRESPONDING #( <entity> ).
    INSERT VALUE #( flag = 'U' data = CORRESPONDING #( ls_status ) ) INTO TABLE lcl_buffer=>mt_buffer.

    mapped-allstatus = VALUE #( BASE mapped-allstatus
                       ( %cid = <entity>-%cid_ref
                         StatusID = ls_status-statusid
                         Status = ls_status-status
                       ) ).

  ENDLOOP.
  ENDMETHOD.
  METHOD DELETE.
  DATA : ls_status TYPE yztstatus.
  LOOP AT KEYS ASSIGNING FIELD-SYMBOL(<entity>).

    ls_status = CORRESPONDING #( <entity> ).
    INSERT VALUE #( flag = 'D' data = CORRESPONDING #( ls_status ) ) INTO TABLE lcl_buffer=>mt_buffer.

    mapped-allstatus = VALUE #( BASE mapped-allstatus
                       ( %cid = <entity>-%cid_ref
                         StatusID = ls_status-statusid
                         Status = ls_status-status
                       ) ).

  ENDLOOP.
  ENDMETHOD.
  METHOD LOCK.
  ENDMETHOD.
  METHOD READ.

    LOOP AT keys INTO DATA(key).
      " check if it is in buffer (and not deleted).
      READ TABLE lcl_buffer=>mt_buffer WITH KEY statusid = key-StatusID status = key-Status INTO DATA(ls_status).
      IF sy-subrc = 0 AND ls_status-flag <> 'U'.
        INSERT CORRESPONDING #( ls_status-data ) INTO TABLE result.
      ELSE.
        SELECT SINGLE * FROM yztstatus WHERE statusid = @key-StatusID and status = @key-Status INTO @DATA(ls_db).
        IF sy-subrc = 0.
          INSERT CORRESPONDING #( ls_db ) INTO TABLE result.
        ELSE.
          INSERT VALUE #( statusid = key-StatusID status = key-Status ) INTO TABLE failed-allstatus.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
CLASS LCL_YR_ALLSTATUS01TP DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      FINALIZE REDEFINITION,
      CHECK_BEFORE_SAVE REDEFINITION,
      SAVE REDEFINITION,
      CLEANUP REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LCL_YR_ALLSTATUS01TP IMPLEMENTATION.
  METHOD FINALIZE.
  ENDMETHOD.
  METHOD CHECK_BEFORE_SAVE.
  ENDMETHOD.
  METHOD SAVE.

   DATA lt_data TYPE STANDARD TABLE OF yztstatus.

    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE  ( flag = 'C' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      INSERT yztstatus FROM TABLE @lt_data.
    ENDIF.
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE  ( flag = 'U' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      UPDATE yztstatus FROM TABLE @lt_data.
    ENDIF.
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE  ( flag = 'D' ) (  row-data ) ).
    IF lt_data IS NOT INITIAL.
      DELETE yztstatus FROM TABLE @lt_data.
    ENDIF.

  ENDMETHOD.
  METHOD CLEANUP.
  ENDMETHOD.
  METHOD CLEANUP_FINALIZE.
  ENDMETHOD.
ENDCLASS.
