@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Item'
define view entity YZI_SOITM as select from YZP_SOITM as Soitm
association to parent YZI_SOHDR as _Sohdr on $projection.Mainuuid = _Sohdr.Mainuuid
{
  key Soitm.Itemuuid as Itemuuid,
      Soitm.Mainuuid as Mainuuid,
      Soitm.Soid as Soid,
      Soitm.Soitem as Soitem,
      Soitm.Productid as Productid,
      Soitm.Quantity as Quantity,
      Soitm.Uom as Uom,
      Soitm.Price as Price,  
      Soitm.Currencycode as Currencycode,
     @Semantics.user.createdBy: true
     Soitm.LocalCreatedBy      as LocalCreatedBy,
     @Semantics.systemDateTime.createdAt: true
     Soitm.LocalCreatedAt      as LocalCreatedAt,
     @Semantics.user.lastChangedBy: true
     Soitm.LocalLastChangedBy as LocalLastChangedBy,
     //local ETag field --> OData ETag
     @Semantics.systemDateTime.localInstanceLastChangedAt: true
     Soitm.LocalLastChangedAt as LocalLastChangedAt,
     //total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      Soitm.LastChangedAt       as LastChangedAt,
    _Sohdr // Make association public
}
