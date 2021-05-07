import json
import pexpect
import os
from packages import hpcs as hpcs
from packages import custom as custom
import re
import subprocess

# --------------------------------------------
# GET INPUTS From Null resource
# --------------------------------------------
inputfile = os.environ.get("INPUT_FILE","")
tke_files_path=os.environ.get("CLOUDTKEFILES","")
hpcs_guid = os.environ.get("HPCS_GUID","")

# Get HPCS instance number
cmd_exe = subprocess.run(["chmod", "u+x", "hpcs_inst_num.sh"], capture_output=True)
run_command = "./hpcs_inst_num.sh '%s'" % (str(hpcs_guid))
os.system(run_command)
out = subprocess.run(["cat", "./temp.txt"], capture_output=True)
out_num = out.stdout.decode("utf-8")
inst_num = str(out_num.strip())
print(inst_num)
deletetempfile = subprocess.run(["rm", "-r", "./temp.txt"], capture_output=True)

# print(pexpect.run('ibmcloud iam oauth-tokens'))
if inputfile == "":
    print("[ERROR] Unable to read file or Provided file is empty")
try:
    with open(inputfile) as complex_data:
        d = complex_data.read()
        data = json.loads(d)
        print(data)
except Exception as error:
    print("[ERROR] Unable to read data from  input file", error)
else:

    # --------------------------------------------
    # Declare JSON input key-values
    # --------------------------------------------
    admin1_name=str(data["admin_name"][0])
    admin1_password=str(data["admin_password"][0])
    admin2_name=str(data["admin_name"][1])
    admin2_password=str(data["admin_password"][1])
    admin_num=str(len(data["admin_name"]))
    print("------")
    print(admin_num)
    threshold_value = str(data["threshold"])
    rev_threshold_value = str(data["rev_threshold"])
    print(admin1_name,admin1_password,admin2_name,admin2_password,admin_num,threshold_value,threshold_value)
    # random_mk=[]
    # custom_mk=[]
    # if "random_mk" in data.keys():
    #     random_mk=data["random_mk"]
    # if "custom_mk" in data.keys():
    #     custom_mk=data["custom_mk"]
    # ----------------------------------------------------------------------------------------
    # Create custom directory in the output path provided inorder to avoid misplacement of data
    # ----------------------------------------------------------------------------------------
    resultDir = custom.custom_tke_files_path(tke_files_path,hpcs_guid)
    os.environ['CLOUDTKEFILES'] = resultDir
    os.system("echo [INFO] TKE Files will be located at $CLOUDTKEFILES")

    # -----------------------------------------------------------------------------------
    # List Crypto units and format the output to get guid-crypto_unit_num key-val pair
    # -----------------------------------------------------------------------------------
    cu_list= hpcs.list_crypto_units()

    cu_num_dict = custom.conv_cu_list_dict(cu_list)

    cu_num = custom.get_cu_num(hpcs_guid,cu_num_dict)

    # --------------------------------------------
    # Add Crypto unit
    # --------------------------------------------
    hpcs.crypto_unit_add(cu_num)

    # --------------------------------------------
    # auto-init HPCS instance
    # --------------------------------------------
    # auto_init = hpcs.auto_init(inst_num,threshold_value,rev_threshold_value)
    # auto_init = hpcs.auto_init(inst_num,threshold_value,rev_threshold_value,admin_num,admin1_name,admin1_password,admin2_name,admin2_password)

    print(inst_num)
    print(threshold_value)
    print(rev_threshold_value)
    print(admin_num)
    print(admin1_name)
    print(admin1_password)
    print(admin2_name)
    print(admin2_password)

    hpcs.auto_init(inst_num,threshold_value,rev_threshold_value,admin_num,admin1_name,admin1_password,admin2_name,admin2_password)

    