#!/bin/sh
# Create texlive.profile using the shell, directly copying file is causing encoding issues between Windows/Unix
cat <<EOF > texlive.profile
TEXDIR /usr/local/texlive/
TEXMFCONFIG ~/.texlivetexmf-config
TEXMFHOME ~/texmf
TEXMFLOCAL /usr/local/texlive/texmf-local
TEXMFSYSCONFIG /usr/local/texlive/texmf-config
TEXMFSYSVAR /usr/local/texlive/texmf-var
TEXMFVAR ~/.texlive/texmf-var
selected_scheme scheme-full
binary_x86_64-linux 1
instopt_adjustpath 1
instopt_adjustrepo 1
instopt_letter 0
instopt_portable 0
instopt_write18_restricted 1
tlpdbopt_autobackup 1
tlpdbopt_backupdir tlpkg/backups
tlpdbopt_create_formats 1
tlpdbopt_file_assocs 1
tlpdbopt_generate_updmap 0
tlpdbopt_post_code 1
tlpdbopt_sys_bin /usr/local/bin
tlpdbopt_sys_info /usr/local/info
tlpdbopt_sys_man /usr/local/man
tlpdbopt_w32_multi_user 1
tlpdbopt_desktop_integration 0
tlpdbopt_install_docfiles 0
tlpdbopt_install_srcfiles 0
EOF
