@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface View forYR_PRODUCT'
define view entity YI_YR_PRODUCT
  as select from YZTPROD as YR_PRODUCT
{
  key PRODUCTID as ProductID,
  PRODUCTNAME as Productname,
  @Semantics.amount.currencyCode: 'Currencycode'
  BASEPRICE as Baseprice,
  CURRENCYCODE as Currencycode,
  UOM as Uom,
  STATUS as Status,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.lastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt
  
}
