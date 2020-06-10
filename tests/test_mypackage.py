import os
import subprocess
def test_files():
    File1 = os.path.exists("./iac-bootstrap/infra_builder_terraform.py")
    File2 = os.path.exists("./iac-bootstrap/infra_bootstrap.py")
    File3 = os.path.exists("./iac-bootstrap/install_nginx.py")
    assert File1 is True
    assert File2 is True
    assert File3 is True

def test_infra_bootstrap():

    test_Account = subprocess.Popen("python3 iac-bootstrap/infra_bootstrap.py", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_Account.communicate()[1]
    assert out == b'Missing account argument,Wedeployer Can not run without Account\n'

    test_region = subprocess.Popen("python3 iac-bootstrap/infra_bootstrap.py --account mygroup-myenv --region nowhere", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_region.communicate()[1]
    assert out == b'No Region Found with this Name\nYou must fix errors mentioned above\n'

    test_provider = subprocess.Popen("python3 iac-bootstrap/infra_bootstrap.py --account mygroup-myenv --provider falseprovider", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_provider.communicate()[1]
    assert out == b'Error in provider argument\n'

    test_action = subprocess.Popen("python3 iac-bootstrap/infra_bootstrap.py --account mygroup-myenv --action wrong", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_action.communicate()[1]
    assert out == b"Error ,Bad Action for Terraform,just 'apply','plan' and 'destroy' are available\nYou must fix errors mentioned above\n"


def test_infra_builder_terraform():
    test_Account = subprocess.Popen("python3 iac-bootstrap/infra_builder_terraform.py", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_Account.communicate()[1]
    assert out == b'Missing account argument,Wedeployer Can not run without Account\n'

    os.chdir('./examples/infra-base')
    test_region = subprocess.Popen("python3 ../../iac-bootstrap/infra_builder_terraform.py --account mygroup-myenv --region nowhere", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_region.communicate()[1]
    assert out == b'No Region Found with this Name\nYou must fix errors mentioned above\n'

    test_provider = subprocess.Popen("python3 ../../iac-bootstrap/infra_builder_terraform.py --account mygroup-myenv --provider falseprovider", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_provider.communicate()[1]
    assert out == b'Error in provider argument\n'

    test_action = subprocess.Popen("python3 ../../iac-bootstrap/infra_builder_terraform.py --account mygroup-myenv --action wrong", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_action.communicate()[1]
    assert out == b"Error ,Bad Action for Terraform,just 'apply','plan' and 'destroy' are available\nYou must fix errors mentioned above\n"


    test_layers = subprocess.Popen("python3 ../../iac-bootstrap/infra_builder_terraform.py --account mygroup-myenv --layer wrong_layer", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_layers.communicate()[1]
    assert out == b'Error in layer argument\n'

    test_ignore =  subprocess.Popen("python3 ../../iac-bootstrap/infra_builder_terraform.py --account mygroup-myenv --ignore wrong_layer", stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True)
    out = test_ignore.communicate()[1]
    assert out == b'Error in ignore argument,wrong layer\nYou must fix errors mentioned above\n'
