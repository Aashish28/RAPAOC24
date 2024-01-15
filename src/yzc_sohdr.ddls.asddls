@EndUserText.label: 'SO Header Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YZC_SOHDR
  provider contract transactional_query as projection on YZI_SOHDR
{
    key Mainuuid,
    Soid,
    Customer,
    Totalprice,
    Currencycode,
    Status,
    Orderdate,
    Deliverydate,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Soitm
}
