<!-- ---
!-- title: ./apptainer_utilities/README.md
!-- author: ywatanabe
!-- date: 2024-12-08 01:04:51
!-- --- -->


# Apptainer Utilities

Collection of shell utilities for managing Apptainer/Singularity containers.

## Installation

#### Apptainer itself
1. `$ source src/000_install_apptainer.sh && install_apptainer`
2. `$ source src/000_enable_fakeroot.sh && apptainer_enable_fakeroot`

#### Apptainer Utilities

``` bash
1. `$ source /path/to/apptainer_utilities/entry.sh.source` # in ~/.bashrc

2. Place containers in:
   - Global: `$HOME/.apptainer/`
   - Project-specific: `./.apptainer/`

2. Store images under:
   - APPTAINER_GLOBAL_DIR (~/.apptainer/)
   - APPTAINER_WORK_DIR (./.apptainer/)
```

## Directory Structure

```
$HOME/.apptainer/
├── image.sif              # Static container
├── image.sandbox/         # Development container
├── definitions/           # Container recipes
└── builds/
    └── current/
        ├── snapshots/     # Version history
        ├── sessions/      # Shell logs
        ├── tests/         # Test results
        └── changes/       # Modifications

project_A/.apptainer/
├── image.sif              # Static container
├── image.sandbox/         # Development container
├── definitions/           # Container recipes
└── builds/
    └── current/
        ├── snapshots/     # Version history
        ├── sessions/      # Shell logs
        ├── tests/         # Test results
        └── changes/       # Modifications

project_B/.apptainer/
├── image.sif              # Static container
├── image.sandbox/         # Development container
├── definitions/           # Container recipes
└── builds/
    └── current/
        ├── snapshots/     # Version history
        ├── sessions/      # Shell logs
        ├── tests/         # Test results
        └── changes/       # Modifications
```

## Commands

| Category | Command | Description | Example Usage |
|----------|---------|-------------|---------------|
| **Building** |
| | `abuild_sif_from_def` | Build SIF from def file | `abuild_sif_from_def recipe.def` |
| | `abuild_sandbox_from_def` | Build sandbox from def | `abuild_sandbox_from_def recipe.def` |
| | `abuild_sandbox_from_sif` | Convert SIF to sandbox | `abuild_sandbox_from_sif image.sif` |  
| | `abuild_sif_from_sandbox` | Convert sandbox to SIF | `abuild_sif_from_sandbox image.sandbox` |
| **Development** |
| | `adev` | Interactive dev environment | `adev project_name` |
| **Static SIF** |
| | `ashell` | Shell into SIF | `ashell image.sif` |
| | `apy` | Run Python | `apy script.py` |
| | `aipy` | Run IPython | `aipy` |
| | `ajpy` | Run Jupyter | `ajpy notebook.ipynb` |
| **Sandbox** |
| | `ashell_sand` | Shell into sandbox | `ashell_sand image.sandbox` |
| | `apy_sand` | Run Python | `apy_sand script.py` |
| | `aipy_sand` | Run IPython | `aipy_sand` |
| | `ajpy_sand` | Run Jupyter | `ajpy_sand notebook.ipynb` |

## Environment Variables 

| Variable | Description | Default |
|----------|-------------|---------|
| `APPTAINER_GLOBAL_DIR` | Global container dir | `$HOME/.apptainer/` |
| `APPTAINER_LOCAL_DIR` | Local container dir | `./.apptainer/` |
| `APPTAINER_RUNTIME_OPTIONS` | Default runtime options | `"--fakeroot --cleanenv --nv"` |

## Dependencies

- Apptainer/Singularity
- rsync
- diffutils
- bash 4+
- Python (for Python operations)

## License

MIT License

## Contact

ywatanabe@alumni.u-tokyo.ac.jp
