@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forYR_PRODUCT'
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
  LastChangedAt
  
}
