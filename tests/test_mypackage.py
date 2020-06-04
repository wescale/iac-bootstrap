import os
def test_files():
    File1 = os.path.exists("./iac-bootstrap/infra_builder_terraform.py")
    File2 = os.path.exists("./iac-bootstrap/infra_bootstrap.py")
    File3 = os.path.exists("./iac-bootstrap/install_nginx.py")
    assert File1 is True
    assert File2 is True
    assert File3 is True
