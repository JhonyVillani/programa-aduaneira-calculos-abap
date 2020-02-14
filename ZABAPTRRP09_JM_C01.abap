*&---------------------------------------------------------------------*
*&  Include           ZABAPTRRP09_JM_C01
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_aduaneira DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_aduaneira DEFINITION.

  PUBLIC SECTION.
*   Tabela do tipo utilizado com a massa de dados
    DATA:mt_movimentacoes TYPE TABLE OF ztreina_rr03.

*   Tabela que possui os países e classes
    DATA: mt_classes TYPE TABLE OF zabaptrt06_jm.

    METHODS:
      constructor,
      selecao,
      processamento,
      exibicao.
  PRIVATE SECTION.
    METHODS:
     get_calc_class
      IMPORTING
        iv_pais TYPE zabaptrde17_jm
      RETURNING
      value(rv_class) TYPE zabaptrt06_jm.

ENDCLASS.                    "lcl_aduaneira DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_aduaneira IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_aduaneira IMPLEMENTATION.
* Seleciona tudo contido na tabela de países e classes e joga em mt_classes
  METHOD constructor.
    SELECT *
          FROM zabaptrt06_jm
          INTO TABLE mt_classes.
  ENDMETHOD.                    "constructor

  METHOD selecao.
    SELECT *
      FROM ztreina_rr03
      INTO TABLE mt_movimentacoes.
  ENDMETHOD.                    "selecao

  METHOD processamento.
*   Estrutura do tipo utilizado com a massa de dados
    DATA: ls_movimentacao TYPE ztreina_rr03.

*   Estrutura que possui os países e classes
    DATA: lv_classe_de_calc TYPE ZABAPTRDE18_JM.

    LOOP AT mt_movimentacoes INTO ls_movimentacao.
      CLEAR lv_classe_de_calc.

*     Exporta o país da massa que será verificado no método e retorna o tipo de classe
      lv_classe_de_calc = get_calc_class( ls_movimentacao-pais_origem ).

    ENDLOOP.
  ENDMETHOD.                    "processamento

  METHOD exibicao.

  ENDMETHOD.                    "exibicao

  METHOD get_calc_class.
    DATA: ls_class TYPE zabaptrt06_jm.

    READ TABLE mt_classes INTO ls_class WITH KEY pais = iv_pais.
    rv_class = ls_class-classe_de_calc.
  ENDMETHOD.                    "get_calc_class

ENDCLASS.                    "lcl_aduaneira IMPLEMENTATION