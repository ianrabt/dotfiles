#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

item: add an item into the menu

    {item => ["command", "label", "icon"]}


cat: add a category into the menu

    {cat => ["name", "label", "icon"]}


begin_cat: begin of a category

    {begin_cat => ["name", "icon"]}


end_cat: end of a category

    {end_cat => undef}


sep: horizontal line separator

    {sep => undef}
    {sep => "label"}


exit: default "Exit" action

    {exit => ["label", "icon"]}


pipe: a pipe menu entry

    {pipe => ["command", "label", "icon"]}


raw: any valid Openbox XML string

    {raw => q(xml string)},


obgenmenu: menu entry provided by obmenu-generator

    {obgenmenu => ["label", "icon"]}

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require '/home/ianrtaylor/.config/obmenu-generator/config.pl';

our $SCHEMA = [
    #          COMMAND             LABEL                ICON
    {item => ['thunar',          'File Manager',      'file-manager']},
    {item => ['urxvt',         'Terminal',          'terminal']},
    {item => ['firefox',       'Web Browser',       'web-browser']},
    {item => ['rhythmbox',     'Music Player',      'applications-multimedia']},
    {item => ['pavucontrol',   'Volume Mixer',      'multimedia-volume-control']},
    {item => ['gmrun',         'Run command',       'system-run']},
    {item => ['skype',         'Skype',             'system-users']},

    {sep => 'Applications'},

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Accessories', 'applications-utilities']},
    {cat => ['development', 'Development', 'applications-development']},
    {cat => ['education',   'Education',   'applications-science']},
    {cat => ['game',        'Games',       'applications-games']},
    {cat => ['graphics',    'Graphics',    'applications-graphics']},
    {cat => ['audiovideo',  'Multimedia',  'applications-multimedia']},
    {cat => ['network',     'Network',     'applications-internet']},
    {cat => ['office',      'Office',      'applications-office']},
    {cat => ['other',       'Other',       'applications-other']},
    {cat => ['settings',    'Settings',    'applications-accessories']},
    {cat => ['system',      'System',      'applications-system']},

    #{cat => ['qt',          'QT Applications',    'qtlogo']},
    #{cat => ['gtk',         'GTK Applications',   'gnome-applications']},
    #{cat => ['x_xfce',      'XFCE Applications',  'applications-other']},
    #{cat => ['gnome',       'GNOME Applications', 'gnome-applications']},
    #{cat => ['consoleonly', 'CLI Applications',   'applications-utilities']},

    #                  LABEL          ICON
    #{begin_cat => ['My category',  'cat-icon']},
    #             ... some items ...
    #{end_cat   => undef},

    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

    {sep       => undef},
    {obgenmenu => ['Openbox Settings', 'applications-engineering']},
    {sep       => undef},

    {item => ['gnome-screensaver-command -l',      'Lock Screen', 'lock']},
    {item => ['systemctl suspend',  'Sleep',       'lock']},    
    {item => ['systemctl reboot',   'Restart',     'lock']},
    {item => ['systemctl poweroff', 'Shutdown',    'lock']},
    {sep       => undef},

    # This options uses the default Openbox's action "Exit"
    {exit => ['Exit', 'exit']},
]
