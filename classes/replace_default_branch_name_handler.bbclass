## This class provides a workaround to avoid creating a bbappend file for recipes
## whose branches were renamed from master to main in older Yocto Project versions.
## To use it, inherit the class in a global configuration file, such as local.conf,
## as shown below:
##
## INHERIT += "replace_default_branch_name_handler"
## REPLACE_DEFAULT_BRANCH_LIST = "<path-to-file-conf>/recipes-list-to-change.conf"
##
## The REPLACE_DEFAULT_BRANCH_LIST variable specifies the path to a configuration
## file containing a list of recipes with the branch attributes to be updated. The
## format of the file should be as follows:
##
## <recipe-name> <old-branch-name> <new-branch-name>
## <recipe-name2> <old-branch-name2> <new-branch-name2>
## ...
##
## For example:
##
## my-recipe master main
## another-recipe old-branch new-branch
##
## Note: It is recommended to keep your Yocto platform updated with the latest 
## releases whenever possible.

python replace_default_branch_name () {
    recipe_list_to_rework = d.getVar('REPLACE_DEFAULT_BRANCH_LIST', True)
    
    if not recipe_list_to_rework:
        bb.debug(1, "Variscite List handler: REPLACE_DEFAULT_BRANCH_LIST is not set.")
        return

    with open(recipe_list_to_rework, 'r') as recipe_list_to_rework_fd:
        for line in recipe_list_to_rework_fd.readlines():
            recipe_name, old_branch, new_branch = line.split()
            if recipe_name in d.getVar('PN'):
                src_uri_replaced = d.getVar('SRC_URI').replace(f"branch={old_branch}", f"branch={new_branch}")
                d.setVar('SRC_URI', src_uri_replaced)
}

replace_default_branch_name[eventmask] = "bb.event.RecipePreFinalise"
addhandler replace_default_branch_name
