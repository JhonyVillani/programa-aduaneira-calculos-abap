*&---------------------------------------------------------------------*
*& Report  ZABAPTRRP09_JM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZABAPTRRP09_JM.

INCLUDE zabaptrrp09_jm_c01. "Include para primeira classe do programa

DATA: go_aduaneira TYPE REF TO lcl_aduaneira. "Classe local

START-OF-SELECTION.
  CREATE OBJECT go_aduaneira.

  go_aduaneira->selecao( ).

  go_aduaneira->processamento( ).

  go_aduaneira->exibicao( ).