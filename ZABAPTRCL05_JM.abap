class ZABAPTRCL05_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL05_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL05_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.

*    FRA:
*    Declarado até 600 ISENTO, 13% do excedente
*NÃO Declarado 25% sobre o produto + R$125 de multa

  DATA: lv_excedente TYPE pad_amt7s.

  IF iv_declarado IS INITIAL. "Não declarado
    ev_valor_multa = 125.
    ev_valor_imposto = iv_valor_produto * '0.25'.
    ev_valor_total = ev_valor_imposto + ev_valor_multa.
    ev_status = 'Imposto de 25% cobrado sobre o valor do produto + R$125 de multa.'.
  ELSE.
    IF iv_valor_produto > 600.
      lv_excedente = iv_valor_produto - 600.
      ev_valor_imposto = lv_excedente * '0.13'. "Formato internacional para cálculo de porcentagem
      ev_valor_total = ev_valor_imposto.
      ev_status = 'Imposto de 13% cobrado sobre valores excedentes a R$600,00.'.
    ENDIF.
    ev_status = 'Isento.'.
  ENDIF.
ENDMETHOD.
ENDCLASS.