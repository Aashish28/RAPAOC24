@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Header'
define root view entity YZI_SOHDR as select from YZP_SOHDR as Sohdr
composition [0..*] of YZI_SOITM as _Soitm 
{
     key Sohdr.Mainuuid as Mainuuid,
     Sohdr.Soid as Soid,
     Sohdr.Customer as Customer,
     Sohdr.Totalprice as Totalprice,
     Sohdr.Currencycode as Currencycode,
     Sohdr.Status as Status,
     Sohdr.Orderdate as Orderdate,
     Sohdr.Deliverydate as Deliverydate,
     @Semantics.user.createdBy: true
     Sohdr.LocalCreatedBy      as LocalCreatedBy,
     @Semantics.systemDateTime.createdAt: true
     Sohdr.LocalCreatedAt      as LocalCreatedAt,
     @Semantics.user.lastChangedBy: true
     Sohdr.LocalLastChangedBy as LocalLastChangedBy,
     //local ETag field --> OData ETag
     @Semantics.systemDateTime.localInstanceLastChangedAt: true
     Sohdr.LocalLastChangedAt as LocalLastChangedAt,
     //total ETag field
      @Semantics.systemDateTime.lastChangedAt: true
      Sohdr.LastChangedAt       as LastChangedAt,


    _Soitm // Make association public
}
