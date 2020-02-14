class ZABAPTRCL08_JM definition
  public
  final
  create public .

public section.

  interfaces ZABAPTRIF01_JM .
protected section.
private section.
ENDCLASS.



CLASS ZABAPTRCL08_JM IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZABAPTRCL08_JM->ZABAPTRIF01_JM~CALCULO
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALOR_PRODUTO               TYPE        PAD_AMT7S
* | [--->] IV_DECLARADO                   TYPE        FLAG
* | [<---] EV_STATUS                      TYPE        BAPI_MSG
* | [<---] EV_VALOR_IMPOSTO               TYPE        PAD_AMT7S
* | [<---] EV_VALOR_MULTA                 TYPE        PAD_AMT7S
* | [<---] EV_VALOR_TOTAL                 TYPE        PAD_AMT7S
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ZABAPTRIF01_JM~CALCULO.

*    COL:
*    Declarado 10% do produto
*NÃO Declarado 20% sobre o produto + 1% do produto de multa

  IF iv_declarado IS INITIAL. "Não declarado
    ev_valor_multa = IV_VALOR_PRODUTO * '0.01'.
    ev_valor_imposto = iv_valor_produto * '0.20'.
    ev_valor_total = ev_valor_imposto + ev_valor_multa.
    ev_status = 'Imposto de 20% cobrado sobre o valor do produto + 1% de multa.'.
  ELSE.
    ev_valor_imposto = iv_valor_produto * '0.10'.
    EV_VALOR_TOTAL = ev_valor_imposto.
    ev_status = 'Imposto de 10% cobrado sobre o valor do produto.'.
  ENDIF.
endmethod.
ENDCLASS.