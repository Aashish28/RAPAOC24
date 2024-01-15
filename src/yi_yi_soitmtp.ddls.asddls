@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View foryi_soitm'
define view entity YI_yi_soitmTP
  as projection on YR_yi_soitmTP as yi_soitm
{
  key ItemUUID,
  MainUUID,
  SoID,
  Soitem,
  ProductID,
  Quantity,
  Uom,
  Price,
  Currencycode,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _yi_sohdr : redirected to parent YI_yi_sohdr01TP
}
