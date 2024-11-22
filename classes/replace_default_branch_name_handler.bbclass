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
## <recipe-name> <old-urival> <new-urival>
## <recipe-name2> <old-urival1> <new-urival2>
##
## urival is a certain string to be replaced in the SRC_URI variable. Default usage
## is to replace the branch name in the URI. But for cases, where the branch parameter
## or the SCR_URI contains more then one URL, the urival can be used to replace any
## string in the SRC_URI.
##
## For example:
##
## my-recipe master main
## another-recipe git://github.com/owner/repo.git;protocol=https git://github.com/owner/repo.git;protocol=https;branch=main
##
## Note: It is recommended to keep your Yocto platform updated with the latest 
## releases whenever possible.

python replace_default_branch_name () {
    try:
        recipe_list_to_rework = d.getVar('REPLACE_DEFAULT_BRANCH_LIST', True)

        if not recipe_list_to_rework:
            bb.warn("Variscite List handler: REPLACE_DEFAULT_BRANCH_LIST is not set or empty.")
            return

        try:
            with open(recipe_list_to_rework, 'r') as recipe_list_to_rework_fd:
                for line_number, line in enumerate(recipe_list_to_rework_fd.readlines(), start=1):
                    try:
                        recipe_name, old_urival, new_urival = line.split()
                    except ValueError as e:
                        bb.fatal(f"Malformed line in {recipe_list_to_rework} at line {line_number}: {line.strip()}. Error: {e}")
                        continue

                    if recipe_name in d.getVar('PN'):
                        src_uri = d.getVar('SRC_URI')
                        if old_urival in src_uri:
                            src_uri_replaced = src_uri.replace(f"{old_urival}", f"{new_urival}")
                            d.setVar('SRC_URI', src_uri_replaced)
                        else:
                            bb.warn(f"Old URI '{old_urival}' not found in SRC_URI for recipe {recipe_name}.")
        except FileNotFoundError as e:
            bb.fatal(f"File {recipe_list_to_rework} not found. Ensure the file exists and is accessible. Error: {e}")
        except IOError as e:
            bb.fatal(f"Failed to read file {recipe_list_to_rework}. Error: {e}")

    except Exception as e:
        bb.fatal(f"An unexpected error occurred in replace_default_branch_name: {e}")
}

replace_default_branch_name[eventmask] = "bb.event.RecipePreFinalise"
addhandler replace_default_branch_name
