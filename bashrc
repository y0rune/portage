#!/usr/bin/env bash

if [[ "${FEATURES}" == *ccache* && "${EBUILD_PHASE_FUNC}" == src_* ]]
then
    if [[ "${CCACHE_DIR}" == "${EPREFIX}"/usr/ccache ]]
    then
        # Set the ccache dir to whatever CCACHE_DIR is + category + name of the package
        export CCACHE_DIR="${EPREFIX}"/usr/ccache/${CATEGORY}/${PN}
        mkdir -p "${CCACHE_DIR}" || die "Failed to create ccache directory"
        # Copy ccache.conf if it is found in "old" CCACHE_DIR
        if [ -f "${EPREFIX}"/usr/ccache/ccache.conf ]
        then
            cp "${EPREFIX}"/usr/ccache/ccache.conf /usr/ccache/"${CATEGORY}"/"${PN}"/ccache.conf || die "Failed to copy ccache config"
        fi
    fi
fi


# Verbose ebuild phase

if [ -n "${EBUILD_PHASE}" ] && [ ! "${EBUILD_PHASE}" = "depend" ]
then
    echo "[ $(date +%H:%M:%S) ] ${EBUILD_PHASE^^} for version ${PV} of ${PN} from ${CATEGORY}"
fi
