class ZABAPTRCL09_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL09_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL09_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
METHOD zabaptrif01_jm~calculo.

*    IND:
*    Declarado R$100 + 8% do produto
*NÃO Declarado R$200 + 50% sobre o produto de multa (Caso o valor exceda o valor do produto, iguala o valor do produto)

  IF iv_declarado IS INITIAL. "Não declarado
    ev_valor_imposto = iv_valor_produto * '0.5' + 200.
    IF ev_valor_imposto > iv_valor_produto.
      ev_valor_imposto = iv_valor_produto.
      ev_status = 'Imposto no valor do produto + 50% de multa no valor do imposto.'.
    ELSE.
      ev_status = 'Imposto de 50% sobre o valor do produto + R$200.'.
    ENDIF.
    ev_valor_multa = ev_valor_imposto * '0.5'.
    ev_valor_total = ev_valor_imposto + ev_valor_multa.
  ELSE.
    ev_valor_imposto = iv_valor_produto * '0.08' + 100.
    ev_valor_total = ev_valor_imposto.
    ev_status = 'Imposto de 8% cobrado sobre o valor do produto + R$100.'.
  ENDIF.
ENDMETHOD.
ENDCLASS.