@EndUserText.label: 'SO Item Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity YZC_SOITM
  provider contract transactional_query as projection on YZI_SOITM
{
    key Itemuuid,
    Mainuuid,
    Soid,
    Soitem,
    Productid,
    Quantity,
    Uom,
    Price,
    Currencycode,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Sohdr
}
