class ZABAPTRCL07_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL07_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL07_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.

*    SUI:
*    Declarado Isento
*NÃO Declarado 10% sobre o produto + R$120 de multa

  IF iv_declarado IS INITIAL. "Não declarado
    ev_valor_multa = 120.
    ev_valor_imposto = iv_valor_produto * '0.1'.
    ev_valor_total = ev_valor_imposto + ev_valor_multa.
    ev_status = 'Imposto de 10% cobrado sobre o valor do produto + R$120 de multa.'.
  ELSE.
    ev_status = 'Isento.'.
  ENDIF.

ENDMETHOD.
ENDCLASS.