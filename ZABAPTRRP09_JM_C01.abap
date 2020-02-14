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

    TYPES:
      BEGIN OF ty_s_dados_processados,
        protocolo     TYPE char6,
        descr_produto	TYPE char30,
        declarado	    TYPE char2,
        pais_origem	  TYPE char3,
        valor_produto TYPE pad_amt7s,
        status        TYPE bapi_msg,
        valor_imposto	TYPE pad_amt7s,
        valor_multa	  TYPE pad_amt7s,
        valor_total   TYPE pad_amt7s,
      END OF ty_s_dados_processados.

    DATA:mt_movimentacoes      TYPE TABLE OF ztreina_rr03. "Tabela do tipo utilizado com a massa de dados
    DATA: mt_classes           TYPE TABLE OF zabaptrt06_jm. "Tabela que possui os países e classes
    DATA: mt_dados_processados TYPE TABLE OF ty_s_dados_processados. "Tabela de dados retornados com o modelo definido em TYPES

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
    DATA: ls_movimentacao      TYPE ztreina_rr03. "Estrutura do tipo utilizado com a massa de dados
    DATA: lo_calculo           TYPE REF TO zabaptrif01_jm. "Este objeto referencia um tipo de classe que implementa esta interface
    DATA: lv_classe_de_calc    TYPE zabaptrde18_jm. "Estrutura que possui os países e classes

*   Estrutura final com modelo definido em TYPES
    DATA: ls_dados_processados TYPE ty_s_dados_processados.
    DATA: lv_declarado TYPE flag.

*   Método para obter a classe de um país específico
    LOOP AT mt_movimentacoes INTO ls_movimentacao.
      CLEAR: lv_classe_de_calc, lo_calculo, ls_dados_processados.

*     Exporta o país da massa que será verificado no método e retorna o tipo de classe
      lv_classe_de_calc = get_calc_class( ls_movimentacao-pais_origem ).

      CASE ls_movimentacao-declarado.
        WHEN 'D'.
          lv_declarado = abap_true.
        WHEN 'ND'.
          lv_declarado = space.
        WHEN OTHERS.
          lv_declarado = space.
      ENDCASE.

*     Instância Dinâmica padrão calculo
      CREATE OBJECT lo_calculo TYPE (lv_classe_de_calc).
      lo_calculo->calculo(

*     Método Cálculo padrão por país
      EXPORTING
        iv_valor_produto = ls_movimentacao-valor_produto
        iv_declarado = lv_declarado
        IMPORTING
          ev_valor_total   = ls_dados_processados-valor_total
          ev_valor_imposto = ls_dados_processados-valor_imposto
          ev_valor_multa   = ls_dados_processados-valor_multa
          ev_status        = ls_dados_processados-status ).

*     Populando a estrutura com os cálculos realizados e appendando uma a uma
      ls_dados_processados-protocolo     = ls_movimentacao-protocolo.
      ls_dados_processados-descr_produto = ls_movimentacao-descr_produto.
      ls_dados_processados-pais_origem   = ls_movimentacao-pais_origem.
      ls_dados_processados-declarado     = ls_movimentacao-declarado.
      ls_dados_processados-valor_produto = ls_movimentacao-valor_produto.

      APPEND ls_dados_processados TO mt_dados_processados.

    ENDLOOP.
  ENDMETHOD.                    "processamento

  METHOD exibicao.
    DATA: ls_dados_processados TYPE ty_s_dados_processados.

    LOOP AT mt_dados_processados INTO ls_dados_processados.

      WRITE: / '|---------------------------------------------------------------------------------------------|'.
      WRITE: / '|                         Recibo Aduaneiro                                                    |'.
      WRITE: / '|---------------------------------------------------------------------------------------------|'.
      WRITE: / '|  :: Dados Recebidos                                                                         |'.
      WRITE: / '|     Nº Protocolo '. WRITE: at 35 ls_dados_processados-protocolo.              WRITE: AT 95 '|'.
      write: / '|     Declarado: '. WRITE: at 35 ls_dados_processados-declarado.                WRITE: AT 95 '|'.                                              .
      WRITE: / '|     País de Origem: '. WRITE: at 35 ls_dados_processados-pais_origem.         WRITE: AT 95 '|'.
      WRITE: / '|     Descrição do Produto: '. WRITE: at 35 ls_dados_processados-descr_produto. WRITE: AT 95 '|'.
      WRITE: / '|     Valor do Produto: '. WRITE: ls_dados_processados-valor_produto.           WRITE: AT 95 '|'.
      WRITE: / '|---------------------------------------------------------------------------------------------|'.
      WRITE: / '|  :: Dados Processados                                                                       |'.
      WRITE: / '|     Status:                                                                                 |'.
      WRITE: / '|'. WRITE: AT 7 ls_dados_processados-status.                                    WRITE: AT 95 '|'.
      WRITE: / '|     Taxa/Imposto: '. WRITE: AT 22 ls_dados_processados-valor_imposto.         WRITE: AT 95 '|'.
      WRITE: / '|     Multa: '. WRITE: AT 22 ls_dados_processados-valor_multa.                  WRITE: AT 95 '|'.
      WRITE: / '|     Total a Pagar: '. WRITE: AT 22 ls_dados_processados-valor_total.       WRITE: AT 92 'ITZ|'.
      WRITE: / '|---------------------------------------------------------------------------------------------|'.
      WRITE: /.
    ENDLOOP.

  ENDMETHOD.                    "exibicao

  METHOD get_calc_class.
    DATA: ls_class TYPE zabaptrt06_jm.

    READ TABLE mt_classes INTO ls_class WITH KEY pais = iv_pais.
    rv_class = ls_class-classe_de_calc.
  ENDMETHOD.                    "get_calc_class

ENDCLASS.                    "lcl_aduaneira IMPLEMENTATION