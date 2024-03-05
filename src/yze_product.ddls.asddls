@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Extension View'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'YZA', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'Prod' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity YZE_PRODUCT as select from yztprod as Prod
{
     key productid as ProductID
}
