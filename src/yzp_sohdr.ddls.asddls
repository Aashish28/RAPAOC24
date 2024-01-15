@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YZP_SOHDR as select from yztsohdr
{
    key mainuuid as Mainuuid,
        soid as Soid,
    customer as Customer,
    @Semantics.amount.currencyCode: 'Currencycode'
    totalprice as Totalprice,
    currencycode as Currencycode,
    status as Status,
    orderdate as Orderdate,
    deliverydate as Deliverydate,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
