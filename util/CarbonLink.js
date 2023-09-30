class CarbonLink {
  uuid;
  issuer;
  metricTonsCO2;
  issueDate;
  expiryDate;
  greenHouseGasType;
  standard;
  region;
  projectType;
  price;
  retired;
  description;
  exists;
  risk;
  lastEvaluatedRiskDate;

  constructor({
    uuid,
    issuer,
    metricTonsCO2,
    issueDate,
    expiryDate,
    greenHouseGasType,
    standard,
    region,
    projectType,
    price,
    retired,
    description,
    exists,
    risk,
    lastEvaluatedRiskDate
  }) {
    this.uuid = uuid;
    this.issuer = issuer;
    this.metricTonsCO2 = metricTonsCO2;
    this.issueDate = issueDate;
    this.expiryDate = expiryDate;
    this.greenHouseGasType = greenHouseGasType;
    this.standard = standard;
    this.region = region;
    this.projectType = projectType;
    this.price = price;
    this.retired = retired;
    this.description = description;
    this.exists = exists;
    this.risk = risk;
    this.lastEvaluatedRiskDate = lastEvaluatedRiskDate;
  }
}

export default CarbonLink;
