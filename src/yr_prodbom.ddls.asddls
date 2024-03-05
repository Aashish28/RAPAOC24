@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Bom Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity YR_PRODBOM as select from yztprodbom
association to parent YR_YR_PRODUCTTP as _prod on $projection.Productid = _prod.ProductID
{
    key productid as Productid,
    key bomid as Bomid,
    bomname as Bomname,
    last_changed_at as LastChangedAt,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    last_changed_by as LastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    _prod
}
