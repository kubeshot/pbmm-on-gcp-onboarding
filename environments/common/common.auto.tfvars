/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



org_policies = {
  directory_customer_id = []
  policy_boolean        = { "constraints/compute.skipDefaultNetworkCreation" = true, "constraints/compute.disableSerialPortAccess" = true } #constraints/compute.skipDefaultNetworkCreation = false
  policy_list           = {}
  setDefaultPolicy      = false # leave false for testing
  vmAllowedWithExternalIp = [
    #projects/PROJECT_ID/zones/ZONE/instances/INSTANCE
  ]
  vmAllowedWithIpForward = [
    # projects/PROJECT_ID/zones/ZONE/instances/INSTANCE
  ]
}
folders = {
   # switch out parent depending on whether you are running directly off the organization or a folder
  #parent = "organizations/252632484771" #REQUIRED Edit, format "organizations/#############" or "folders/#############"
  parent = "folders/1096166437458" #REQUIRED Edit, format "organizations/#############" or "folders/#############"
  names  = ["Infrastructure", "Sandbox", "Workloads", "Audit and Security", "Automation", "Shared Services"] # Production, NonProduction and Platform are included in the module
  subfolders_1 = {
    SharedInfrastructure = "Infrastructure"
    Networking           = "Infrastructure"
    Prod                 = "Workloads"
    UAT                  = "Workloads"
    Dev                  = "Workloads"
    Audit                = "Audit and Security"
    Security             = "Audit and Security"
  }
  subfolders_2 = {
    ProdNetworking    = "Networking"
    NonProdNetworking = "Networking"
  }
}

access_context_manager = { # REQUIRED OBJECT. VPC Service Controls object. 
  policy_name         = "" # OPTIONAL EDIT. If null, will be generated by module. Only used when creating new policy.
  policy_id           = "367999605146" # OPTIONAL EDIT. Only used when previously existing. Includes subsequent runs 
  user_defined_string = "acm" # Optional EDIT.
  access_level        = {} # leave empty for testing
}

audit = {                                  # REQUIRED OBJECT. Must include an audit object.
  user_defined_string            = "audit" # REQUIRED EDIT. Must be globally unique, used for the audit project
  additional_user_defined_string = ""      # OPTIONAL EDIT. Optionally append a value to the end of the user defined string.
  billing_account                = "01F01C-EC0BAC-DD9482"      # REQUIRED EDIT. Define the audit billing account
  audit_streams = {
    prod = {
      bucket_name          = "kshotauditbucket"                     # REQUIRED EDIT. Must be globally unique, used for the audit bucket
      is_locked            = false                  # OPTIONAL EDIT. Required value as it cannot be left null.
      bucket_force_destroy = true                   # OPTIONAL EDIT. Required value as it cannot be left null.
      bucket_storage_class = "STANDARD"             # OPTIONAL EDIT. Required value as it cannot be left null.
      labels               = {}                     # OPTIONAL EDIT. 
      sink_name            = "kshotauditsink"                     # REQUIRED EDIT. Must be unique across organization
      description          = "Org Sink"             # OPTIONAL EDIT. Required value as it cannot be left null.
      filter               = "severity >= WARNING"  # OPTIONAL EDIT. Required value as it cannot be left null.
      retention_period     = 1                      # OPTIONAL EDIT. Required value as it cannot be left null.
      bucket_viewer        = "user:udaykakkar@kubeshot.com" # REQUIRED EDIT. 
    }
  }
  audit_lables = {}
}

audit_project_iam = [ #REQUIRED EDIT. At least one object is required. The member cannot be the same for multiple objects.
  {
    member = "user:udaykakkar@kubeshot.com" #REQUIRED EDIT
    #project = module.project.project_id  #(will be added during deployment using local var)
    roles = [
      "roles/viewer",
      "roles/editor",
    ]
  },
/*  {
    member = "group:group2@test.domain.net"
    roles = [
      "roles/viewer",
    ]
  }*/
]


folder_iam = [
  {
    member = "user:udaykakkar@kubeshot.com" # REQUIRED EDIT. user:user@google.com, group:users@google.com,serviceAccount:robot@PROJECT.iam.gserviceaccount.com
    #folder = module.core-folders.folders_map_1_level["Audit"].id #(will be added during deployment using local var)
    audit_folder_name = "Audit" # REQUIRED EDIT. Name of the Audit folder previously defined.
    roles = [
      "roles/viewer",
    ]
  },
]


organization_iam = [
  {
    member       = "user:udaykakkar@kubeshot.com" # REQUIRED EDIT. user:user@google.com, group:users@google.com,serviceAccount:robot@PROJECT.iam.gserviceaccount.com
    organization = "252632484771" #Insert your Ord ID here, format ############
    roles = [
      "roles/viewer",
    ]
  }
]

guardrails = {
  user_defined_string = "guardrails" # Optional EDIT. Must be unique. Defines the guardrails project in form department_codeEnvironmente-owner-user_defined_string
  billing_account     = "01F01C-EC0BAC-DD9482" # REQUIRED EDIT. Billing Account in the format of ######-######-######
  org_id_scan_list = [     # REQUIRED EDIT. Organization Id list for service account to have cloud asset viewer permission
  ]
  org_client = false #Set to true if deploying remote client landing zone.  Otherwise set to false if deploying for core organization landing zone.

}


custom_roles = {} # OPTIONAL EDIT. 
