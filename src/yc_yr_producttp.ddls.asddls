@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forYR_PRODUCT'
@ObjectModel.semanticKey: [ 'ProductID' ]
@Search.searchable: true
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'YZA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ 'YR_PRODUCT' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}

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
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_PRDSTATUS_VH' , element: 'Status' },
                                       useForValidation: true,
                                       label: 'Status'}]                                           
  @ObjectModel.text.element: [ 'PrdText' ]
  Status,  
  _PrdStatus.Text as PrdText,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
