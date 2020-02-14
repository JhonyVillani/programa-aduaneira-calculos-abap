class ZABAPTRCL04_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL04_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL04_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.
*    EUA:
*    Declarado 30% sobre o total
*NÃO Declarado 60% sobre o total + R$100 de taxa

  IF iv_declarado IS INITIAL. "Ou SPACE / ABAP-FALSE
    ev_valor_imposto = iv_valor_produto * '0.6' + 100.
    ev_valor_total = ev_valor_imposto.
    ev_status = 'Imposto de 60% + R$100 de taxa administrativa cobrado sobre produtos não declarados.'.
  ELSE.
    ev_valor_imposto = iv_valor_produto * '0.3'.
    ev_valor_total = ev_valor_imposto.
    ev_status = 'Imposto de 30% cobrado sobre produtos declarados.'.
  ENDIF.

ENDMETHOD.
ENDCLASS.