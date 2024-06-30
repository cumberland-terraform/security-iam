locals {
    platform_templatefile_vars  = {
        # TODO: in case we ever have to template policies!
    }
    platform_policy_fileset     = fileset("${path.module}/policies/platform", "*.tftpl")
    platform_policies           = {
        # take all policies in policies/platform directory
        for index, file_path in local.platform_policy_fileset:
            # map filename without file extension to templated policy string
            split(".", file_path)[0] => 
                templatefile(
                    "${path}/policies/platform/${file_path}", 
                    local.platform_templatefile_vars
                )
    }
}