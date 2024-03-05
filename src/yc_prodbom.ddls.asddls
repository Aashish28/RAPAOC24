@EndUserText.label: 'Product Bom projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity YC_PRODBOM
  as projection on YR_PRODBOM
{
    key Productid,
    key Bomid,
    Bomname,
    LastChangedAt,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _prod : redirected to parent YC_YR_PRODUCTTP
}
