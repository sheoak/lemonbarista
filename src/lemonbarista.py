#!/bin/env python3

import argparse
import os
import sys
import subprocess
# TODO: avoid
import shlex
from pprint import pprint


CONF_DIR = os.path.join(os.path.expanduser('~'), '.config', 'lemonbarista')
PLUGIN_DIR = os.path.dirname(os.path.realpath(__file__))  + "/../plugins/"


# take a dict of options and transform it into a gnu-style arguments list
def options_to_args(name, options):

    args=" --name=" + name

    if options is None:
        return args

    for (arg, value) in options.items():
        args+=" --" + arg + '="' + value + '"'

    return args


# call the given plugin and return the result of execution
def call_plugin(name, options):

    script=PLUGIN_DIR + name + '/' + name + '.sh'
    args=options_to_args(name, options)

    # TODO: handle all types
    # TODO: get in a string
    subprocess.call(shlex.split(script + args))

    # TODO: convert output to dict
    #yaml.load(res))

    # TODO: return formatted string for plugin
    # TODO: add color, icons…

# TODO: handle piped plugins
def load_plugins_part(part):

    for (name, values) in config['plugins'][part].items():
        # TODO: error if not found
        plugin=values.get('plugin', None)
        options=values.get('options', None)

        # TODO: use default tick
        # TODO: handle ticks
        tick=values.get('tick', '2')

        # TODO: concat to final string
        call_plugin(plugin, values.get('options', None))

    return ""


def load_plugins(config):

    out='%{l}'
    #out+=load_plugins_part('left')
    out+='%{r}'
    out+=load_plugins_part('right')

    # formatted string output for lemonbar
    print(out)

def main(config):
    #import ipdb
    #ipdb.set_trace()

    # TODO: clean configuration once for all

    #while True:
    load_plugins(config)
    #time.sleep(2)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Lemonbarista')

    parser.add_argument('-c', '--config', action='store', dest='config_file',
                        default=os.path.join(CONF_DIR, 'config.yaml'),
                        help='Loads the given configuration file')
    parser.add_argument('-t', '--type', action='store', dest='config_type',
                        default=None, choices=('yaml', 'json'),
                        required=False, help='Sets the config type (yaml or '
                        'json)')

    arguments = parser.parse_args()

    try:
        with open(arguments.config_file, 'r') as fd:
            if arguments.config_type is not None:
                config_type = arguments.config_type
            else:
                config_type = arguments.config_file.split('.')[-1].lower()

            if config_type == 'yaml':
                import yaml
                config = yaml.load(fd)
                print('Loading YAML')
            elif config_type == 'json':
                import json
                config = json.load(fd)
                print('Loading JSON')
            else:
                raise ValueError('Type {} unknown'.format(config_type))
    except Exception as e:
        print(e)
        sys.exit(1)

    main(config)
