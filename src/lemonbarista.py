#!/bin/env python3

import argparse
import os
import sys


CONF_DIR = os.path.join(os.path.expanduser('~'), '.config',
                        'lemonbarista')


def main(config):
    import ipdb
    ipdb.set_trace()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Lemonbarista')

    parser.add_argument('-c', '--config', action='store', dest='config_file',
                        default=os.path.join(CONF_DIR, 'config.yaml'),
                        help='Loads the given configuration file')
    parser.add_argument('-t', '--type', action='store', dest='config_type',
                        default='yaml', choices=('yaml', 'json'),
                        required=False, help='Sets the config type (yaml or '
                        'json)')

    arguments = parser.parse_args()

    try:
        with open(arguments.config_file, 'rb') as fd:
            if arguments.config_type == 'yaml':
                import yaml
                config = yaml.load(fd)
                print('Loading YAML')
            elif arguments.config_type == 'json':
                import json
                config = json.load(fd)
                print('Loading JSON')
    except Exception as e:
        print(e)
        sys.exit(1)

    main(config)
