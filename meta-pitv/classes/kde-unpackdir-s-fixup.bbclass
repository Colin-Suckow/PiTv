# Work around meta-kde master lagging behind oe-core master.
#
# ~16 meta-kde recipes still hardcode S = "${UNPACKDIR}/git". Recent oe-core
# makes that a fatal do_unpack QA error (insane.bbclass), because the git
# fetcher now unpacks to ${UNPACKDIR}/${BP} (BB_GIT_DEFAULT_DESTSUFFIX = "${BP}"
# in bitbake.conf) and the default S already points there. So the assignment is
# both redundant and points at the old, no-longer-used "git/" directory.
#
# Reset those recipes to the working default (equivalent to deleting the line).
# Drop this class once meta-kde removes the assignments upstream.
python () {
    if d.getVar('S', False) in ('${UNPACKDIR}/git', '${WORKDIR}/git'):
        d.setVar('S', '${UNPACKDIR}/${BP}')
}
