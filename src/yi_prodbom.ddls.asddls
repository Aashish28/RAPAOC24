@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Bom Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YI_PRODBOM
  as projection on YR_PRODBOM as yztprodbom

{
    key Productid,
    key Bomid,
    Bomname,
    LastChangedAt,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _prod: redirected to parent YI_YR_PRODUCTTP
}
