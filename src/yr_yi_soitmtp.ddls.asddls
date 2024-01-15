@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View foryi_soitm'
define view entity YR_yi_soitmTP
  as select from yztsoitm as yi_soitm
  association to parent YR_yi_sohdr01TP as _yi_sohdr on $projection.MainUUID = _yi_sohdr.MainUUID
  association [0..1] to ZI_PROD_VH as _Prod on $projection.ProductID = _Prod.Productid
{
  key itemuuid as ItemUUID,
  mainuuid as MainUUID,
  soid as SoID,
  soitem as Soitem,
  productid as ProductID,
  @Semantics.quantity.unitOfMeasure: 'Uom'
  quantity as Quantity,
  uom as Uom,
  @Semantics.amount.currencyCode: 'Currencycode'
  price as Price,
  currencycode as Currencycode,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _yi_sohdr,
  _Prod  
}
