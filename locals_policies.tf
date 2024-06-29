locals {
    platform_templatefile_vars  = {

    }
    platform_policy_fileset     = fileset("${path.module}/policies/platform", "*.tftpl")
    platform_policies           = {
        for index, file_path in local.platform_policy_fileset:
            # map filename without file extension to templated policy string
            split(".", file_path)[0] => 
                templatefile(
                    "${path}/policies/platform/${file_path}", 
                    local.platform_templatefile_vars
                )
    }
}