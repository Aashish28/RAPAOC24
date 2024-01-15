@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View foryi_sohdr'
@ObjectModel.semanticKey: [ 'MainUUID' ]
@Search.searchable: true
define root view entity YC_yi_sohdr01TP
  provider contract transactional_query
  as projection on YR_yi_sohdr01TP as yi_sohdr
{
  key MainUUID,
  SoID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.70
  @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer' , element: 'CustomerID' },
                                       useForValidation: true,                                                         
                                       label: 'Customers'}]                                           
  @ObjectModel.text.element: ['CustomerName']
  Customer,
  _Customer.FirstName as CustomerName,
  @Semantics.amount.currencyCode: 'Currencycode'
  Totalprice,
  @Semantics.currencyCode: true
  @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
  Currencycode,
  Status,
  Orderdate,
  Deliverydate,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _Customer,
  _yi_soitm : redirected to composition child YC_yi_soitmTP
  
}
