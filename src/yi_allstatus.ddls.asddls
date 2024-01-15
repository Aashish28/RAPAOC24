@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic Interface View forallstatus'
define view entity YI_allstatus
  as select from YZTSTATUS as allstatus
{
  key STATUSID as StatusID,
  key STATUS as Status,
  TEXT as Text,
  ACTIVE as Active,
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
