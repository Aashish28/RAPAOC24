@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View foryi_soitm'
@ObjectModel.semanticKey: [ 'ItemUUID' ]
@Search.searchable: true
define view entity YC_yi_soitmTP
  as projection on YR_yi_soitmTP as yi_soitm
{
  key ItemUUID,
  MainUUID,
  SoID,
  Soitem,  
  @Search.defaultSearchElement: true
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZI_PROD_VH', element: 'Productid' },
    additionalBinding: [{ localElement: 'Uom', element: 'Uom'},
                      { localElement: 'Currencycode' , element: 'Currencycode'}] 
  }]
  @ObjectModel.text.element: [ 'ProductName' ]
  ProductID,
  _Prod.Productname as ProductName,
  @Semantics.quantity.unitOfMeasure: 'Uom'
  Quantity,
  @Semantics.unitOfMeasure: true
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_UnitOfMeasure', 
      element: 'UnitOfMeasure'
    }, 
    useForValidation: true
  } ]
  Uom,
  @Semantics.amount.currencyCode: 'Currencycode'
  Price,
  @Semantics.currencyCode: true
  @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
  Currencycode,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _yi_sohdr : redirected to parent YC_yi_sohdr01TP,
  _Prod
}
