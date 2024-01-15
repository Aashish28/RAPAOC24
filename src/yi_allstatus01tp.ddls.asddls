@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forallstatus'
define root view entity YI_allstatus01TP
  provider contract transactional_interface
  as projection on YR_allstatus01TP as allstatus
{
  key StatusID,
  key Status,
  Text,
  Active,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
