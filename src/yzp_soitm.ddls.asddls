@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZP_SOITM as select from yztsoitm
{
    key itemuuid as Itemuuid,
    mainuuid as Mainuuid,
    soid as Soid,
    soitem as Soitem,
    productid as Productid,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    quantity as Quantity,
    uom as Uom,
    @Semantics.amount.currencyCode: 'Currencycode'
    price as Price,
    currencycode as Currencycode,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
