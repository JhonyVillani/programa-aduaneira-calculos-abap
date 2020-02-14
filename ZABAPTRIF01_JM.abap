interface ZABAPTRIF01_JM
  public .


  methods CALCULO
    importing
      !IV_VALOR_PRODUTO type PAD_AMT7S
      !IV_DECLARADO type FLAG
    exporting
      !EV_STATUS type BAPI_MSG
      !EV_VALOR_IMPOSTO type PAD_AMT7S
      !EV_VALOR_MULTA type PAD_AMT7S
      !EV_VALOR_TOTAL type PAD_AMT7S .
endinterface.