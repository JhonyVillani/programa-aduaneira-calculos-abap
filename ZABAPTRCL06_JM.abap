class ZABAPTRCL06_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL06_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL06_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.

*    CHN:
*    Até R$1000 ISENTO
*    Acima: multa 10% do produto + 60% do excedente

  DATA: lv_excedente TYPE pad_amt7s.

  IF iv_valor_produto > 1000.
    ev_valor_multa = iv_valor_produto * '0.1'.
    lv_excedente = iv_valor_produto - 1000.
    ev_valor_imposto = lv_excedente * '0.6'. "Formato internacional para cálculo de porcentagem
    ev_valor_total = ev_valor_imposto + ev_valor_multa.
    ev_status = 'Imposto de 60% cobrado sobre valores excedentes a R$1000,00 + 10% do valor do produto.'.
  ELSE.
    ev_status = 'Isento.'.
  ENDIF.

ENDMETHOD.
ENDCLASS.