@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View foryi_sohdr'
define root view entity YR_yi_sohdr01TP
  as select from yztsohdr as yi_sohdr
  composition [0..*] of YR_yi_soitmTP as _yi_soitm
  association [0..1] to I_Currency as _Currency on $projection.Currencycode = _Currency.Currency
  association [0..1] to /DMO/I_Customer as _Customer on $projection.Customer = _Customer.CustomerID
  association [0..1] to ZI_SOSTATUS_VH as _SoStatus on $projection.Status = _SoStatus.Status and _SoStatus.StatusID = 'SO_STATUS' 
{
  key mainuuid as MainUUID,
  soid as SoID,
  customer as Customer,
  @Semantics.amount.currencyCode: 'Currencycode'
  totalprice as Totalprice,
  currencycode as Currencycode,
  status as Status,
  orderdate as Orderdate,
  deliverydate as Deliverydate,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _Currency,
  _Customer,
  _yi_soitm,
  _SoStatus  
}
