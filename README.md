<!-- ---
!-- title: ./apptainer_utilities/README.md
!-- author: ywatanabe
!-- date: 2024-12-08 02:21:33
!-- --- -->


# Apptainer Utils

Collection of utilities for managing Apptainer/Singularity containers.

## Installation

#### Apptainer itself
1. `$ source src/install_apptainer.sh.src && install_apptainer`
2. `$ source src/enable_fakeroot.sh.src && apptainer_enable_fakeroot`

#### Apptainer Utilities

``` bash
1. `$ source /path/to/apptainer_utilities/entry.sh.src` # in ~/.bashrc

2. Place containers in:
   - Global: `$HOME/.apptainer/`
   - Project-specific: `./.apptainer/`

2. Store images under:
   - APPTAINER_GLOBAL_DIR (~/.apptainer/)
   - APPTAINER_WORK_DIR (./.apptainer/)
```

## Initialize/Update Directory Structure

``` bash
$ apptainer_init_or_update_dir -c project_A # or adir
$ apptainer_init_or_update_dir -c project_B # or adir
# Container directory structure updated successfully
#  
# ./.apptainer
# ├── image.sandbox -> project_B/project_B.sandbox
# ├── image.sif -> project_B/project_B.sif
# ├── project_A
# │   ├── definitions
# │   │   ├── differences
# │   │   ├── project_A_latest.def -> project_A_v001.def
# │   │   └── project_A_v001.def
# │   ├── project_A.def -> definitions/project_A_v001.def
# │   ├── project_A.sandbox
# │   ├── project_A.sandbox.log
# │   ├── project_A.sif
# │   └── project_A.sif.log
# └── project_B
#     ├── definitions
#     │   ├── differences
#     │   ├── project_B_latest.def -> project_B_v001.def
#     │   └── project_B_v001.def
#     ├── project_B.def -> definitions/project_B_v001.def
#     ├── project_B.sandbox
#     ├── project_B.sandbox.log
#     ├── project_B.sif
#     └── project_B.sif.log
#  
# 7 directories, 16 files
#  
# You might want to:
#     - Implement ./.apptainer/project_B/definitions/project_B.def
#     - Make ./.apptainer/project_B/definitions/project_B.def
#     - Update symlinks ./.apptainer/image.{sif,sandbox}
```

## Commands

| Category | Command | Description | Example Usage | Example Output |
|----------|---------|-------------|---------------| ---------------|
| **Building** |
| | `abuild_def2sif` | Build SIF from def file | `abuild_sif_from_def /path/to/recipe.def` | `/path/to/recipe.sif`, `/path/to/recipe.sif.log` |
| | `abuild_def2sand` | Build sandbox from def | `abuild_def2sand /path/to/recipe.def` | `/path/to/recipe.sandbox`, `/path/to/recipe.sandbox.log` |
| | `abuild_sand2sif` | Convert sandbox to SIF | `abuild_sand2sif /path/to/image.sandbox` | `/path/to/image.sif`, `/path/to/image.sif.log` |
| | `abuild_sif2sand` | Convert SIF to sandbox | `abuild_sif2sand /path/to/image.sif` | `/path/to/image.sandbox`, `/path/to/image.sandbox.log` |
| **Working with SIF Images** ||
| | `ashell` | Shell into `./.apptainer/image.sif` | `ashell` ||
| | `apy` | Run Python from `./.apptainer/image.sif`| `apy script.py` ||
| | `aipy` | Run IPython from `./.apptainer/image.sif`| `aipy` ||
| | `ajpy` | Run Jupyter from `./.apptainer/image.sif`| `ajpy notebook.ipynb` ||
| **Development of Sandbox Images** |
| | `adev` | Interactively devlop sandbox image | `adev project_A` ||
| **Working with Sandbox Images** |
| | `ashells` | Shell into `./.apptainer/image.sandbox` | `ashell_sand` ||
| | `apys` | Run Python from `./.apptainer/image.sandbox`| `apy_sand script.py` ||
| | `aipys` | Run IPython from `./.apptainer/image.sandbox`| `aipy_sand` ||
| | `ajpys` | Run Jupyter from `./.apptainer/image.sandbox`| `ajpy_sand notebook.ipynb` ||

## Environment Variables 

| Variable | Description | Default |
|----------|-------------|---------|
| `APPTAINER_GLOBAL_DIR` | Global container dir | `$HOME/.apptainer/` |
| `APPTAINER_LOCAL_DIR` | Local container dir | `./.apptainer/` |
| `APPTAINER_RUNTIME_OPTIONS` | Default runtime options | `"--fakeroot --cleanenv --nv"` |

## License

MIT License

## Contact

ywatanabe@alumni.u-tokyo.ac.jp
