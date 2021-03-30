#!/usr/bin/env fish

function upgrade_item
    set -l docstring $argv[1]
    set -l cmd $argv[2..-1]

    echo -ne "\n💾>> "
    echo $docstring
    while true
        read -l -P "Run $cmd? [y/N] " confirm

        switch $confirm
            case Y y
                $cmd
                return $status
            case N n
                return 0
        end
    end
end

function upgrade
    upgrade_item "upgrade Doom Emacs" doom upgrade
    and upgrade_item "upgrade Flatpak" flatpak update
    and upgrade_item "list RPM changelogs" dnf changelog --upgrades
    and upgrade_item "upgrade RPMs" sudo dnf upgrade
    and upgrade_item "upgrade DevKitPro" sudo pacman -Syu
    and upgrade_item "upgrade firmware" sudo fwupdmgr upgrade
end
