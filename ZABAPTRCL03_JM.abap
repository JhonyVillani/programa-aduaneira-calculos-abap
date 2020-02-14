class ZABAPTRCL03_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL03_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL03_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.
*Paraguai, o valor do imposto é calculado em 10% do valor excedente à 500 reais
  DATA: lv_excedente TYPE pad_amt7s.
  IF iv_valor_produto > 500.
    lv_excedente = iv_valor_produto - 500.
    ev_valor_imposto = lv_excedente * '0.1'. "Formato internacional para cálculo de porcentagem
    ev_valor_total = ev_valor_imposto.
    ev_status = 'Imposto de 10% cobrado sobre valores excedentes a R$500,00.'.
  ELSE.
    ev_status = 'Isento.'.
  ENDIF.
ENDMETHOD.
ENDCLASS.