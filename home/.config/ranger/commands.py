from __future__ import (absolute_import, division, print_function)

from ranger.api.commands import *

import os

class emptytrash(Command):
    """:empty

    Empties the trash 
    """

    def execute(self):
        HOME = os.environ['HOME']
        self.fm.run(f'trash-empty')

