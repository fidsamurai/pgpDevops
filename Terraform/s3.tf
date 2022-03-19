provider "aws"
resource "s3" "pgpDevops-fid" {
  tags = {
    Name = "pgpDevops-fid"
    Env = "pgpDevops"
  }
}
