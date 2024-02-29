@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forYR_PRODUCT'
define root view entity YR_YR_PRODUCTTP
  as select from YI_YR_PRODUCT as YR_PRODUCT
  association [0..1] to ZI_PRDSTATUS_VH as _PrdStatus on $projection.Status = _PrdStatus.Status and _PrdStatus.StatusID = 'PRD_STATUS' 
{
  key ProductID,
  Productname,
  @Semantics.amount.currencyCode: 'Currencycode'
  Baseprice,
  Currencycode,
  Uom,
  Status,
  @Semantics.user.createdBy: true
  LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LocalCreatedAt,
  @Semantics.user.lastChangedBy: true
  LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LastChangedAt,
  _PrdStatus  
}
