#! python
import sys
import ConfigParser
from misc import walk_map, is_simulation_dir
from os.path import join
from math import pi
import math 

DESCRIPTION = 'input.dis.description'

def print_density(dirpath, dirnames, filenames):
    if DESCRIPTION not in filenames: return

    config = create_config_from_file(join(dirpath, DESCRIPTION))
    h = float(config.get('DEFAULT', 'HEIGHT'))
    x = float(config.get('DEFAULT', 'X_DIMENSION'))
    y = float(config.get('DEFAULT', 'Y_DIMENSION'))
    spheres_num = float(config.get('DEFAULT', 'number_of_particles'))

    print(math.pi/6*spheres_num / (h*x*y), dirpath)


def create_config_from_file(filepath):
  config = ConfigParser.SafeConfigParser()
  config.optionxform=str
  with open(filepath, 'r') as input: config.readfp(input)
  return config

if __name__ == "__main__":
    (exe, root_path) = sys.argv
    walk_map(root_path, print_density)
