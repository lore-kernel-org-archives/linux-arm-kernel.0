From: leoyang.li@nxp.com (Li Yang)
Date: Mon,  1 Oct 2018 17:58:27 -0500
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
Message-ID: <20181001225827.21946-1-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please merge the updated fix for the following issue.

Regards,
Leo

The following changes since commit 96fc74333f84cfdf8d434c6c07254e215e2aad00:

  soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-25 13:57:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-fix-v4.19-2

for you to fetch changes up to 5a1eb8b9542884592a018829bb1ff20c9695d925:

  soc: fsl: qman_portals: defer probe after qman's probe (2018-10-01 17:47:43 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v4.19 round 2

- Fix crash of qman_portal by deferring its probe if qman is not probed

----------------------------------------------------------------
Laurentiu Tudor (2):
      soc: fsl: qbman: add APIs to retrieve the probing status
      soc: fsl: qman_portals: defer probe after qman's probe

 drivers/soc/fsl/qbman/bman_ccsr.c   | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c   | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_portal.c |  8 ++++++++
 include/soc/fsl/bman.h              |  8 ++++++++
 include/soc/fsl/qman.h              |  8 ++++++++
 5 files changed, 46 insertions(+)
