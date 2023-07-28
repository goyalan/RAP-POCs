CLASS zcl_hello_world2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun . "Provides a light weighted solu to display output in console istead of gui

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HELLO_WORLD2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



  out->write( |Hello world! ({ cl_abap_context_info=>get_user_alias(  ) })| ). "cl_abap_context_info - this class is used for system variebles .

  ENDMETHOD.
ENDCLASS.
