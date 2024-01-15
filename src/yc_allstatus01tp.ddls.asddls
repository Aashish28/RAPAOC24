@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forallstatus'
@ObjectModel.semanticKey: [ 'StatusID','Status' ]
@Search.searchable: true
define root view entity YC_allstatus01TP
  provider contract transactional_query
  as projection on YR_allstatus01TP as allstatus
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key StatusID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Status,
  Text,
  Active,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
