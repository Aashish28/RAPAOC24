@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forYR_PRODUCT'
@ObjectModel.semanticKey: [ 'ProductID' ]
@Search.searchable: true
define root view entity YC_YR_PRODUCTTP
  provider contract transactional_query
  as projection on YR_YR_PRODUCTTP as YR_PRODUCT
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key ProductID,
  Productname,
  @Semantics.amount.currencyCode: 'Currencycode'
  Baseprice,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Currency', 
      element: 'Currency'
    }, 
    useForValidation: true
  } ]
  Currencycode,
  Uom,
  Status,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
