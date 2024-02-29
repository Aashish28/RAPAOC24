@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SO Status value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_SOSTATUS_VH as select from YI_allstatus
{
    @ObjectModel.text.element: [ 'Text' ]
    key Status,
    @Semantics.text: true
    Text,
    StatusID
} where Active = 'X' and StatusID = 'SO_STATUS'
