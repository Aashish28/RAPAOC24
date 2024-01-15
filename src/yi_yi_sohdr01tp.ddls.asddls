@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View foryi_sohdr'
define root view entity YI_yi_sohdr01TP
  provider contract transactional_interface
  as projection on YR_yi_sohdr01TP as yi_sohdr
{
  key MainUUID,
  SoID,
  @ObjectModel.text.association: '_Customer'
  Customer,
  Totalprice,
  @ObjectModel.foreignKey.association: '_Currency'
  Currencycode,
  Status,
  Orderdate,
  Deliverydate,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _Currency,
  _Customer,
  _yi_soitm : redirected to composition child YI_yi_soitmTP
  
}
