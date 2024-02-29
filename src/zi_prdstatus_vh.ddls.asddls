@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Status value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_PRDSTATUS_VH as select from YI_allstatus
{
    @ObjectModel.text.element: [ 'Text' ]
    key Status,
    @Semantics.text: true
    Text,
    StatusID
} where Active = 'X' and StatusID = 'PRD_STATUS'
