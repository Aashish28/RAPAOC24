@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forYR_PRODUCT'
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
define root view entity YI_YR_PRODUCTTP
  provider contract transactional_interface
  as projection on YR_YR_PRODUCTTP as YR_PRODUCT
{
  key ProductID,
  Productname,
  Baseprice,
  Currencycode,
  Uom,
  Status,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _PrdStatus
}
