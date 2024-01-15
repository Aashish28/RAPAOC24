@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true

define view entity ZI_PROD_VH as select from yztprod
{
    @ObjectModel.text.element: [ 'Productname' ]
    @Search.defaultSearchElement: true
    key productid as Productid,
    @Search.defaultSearchElement: true
    @Semantics.text: true
    productname as Productname,
    @Semantics.amount.currencyCode: 'Currencycode'
    baseprice as Baseprice,
    currencycode as Currencycode,
    uom as Uom,
    status as Status
}
