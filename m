From: leoyang.li@nxp.com (Li Yang)
Date: Mon, 24 Sep 2018 17:20:17 -0500
Subject: [GIT PULL] updates for soc/fsl drivers for v4.20
Message-ID: <20180924222017.30522-1-leoyang.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please pull soc/fsl drivers updates for v4.20.

Regards,
Leo

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-next-v4.20

for you to fetch changes up to afa86d264a7ce62ba214bc7c6012e2129141421e:

  soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v4.20

- Use of_get_child_by_name helper for QE driver
- Remove redundant pointer 'priv' for dpio driver

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: dpio: remove redundant pointer 'priv'

Rob Herring (1):
      soc: fsl/qe: Use of_get_child_by_name helper

 drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
 drivers/soc/fsl/qe/qe.c            | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)
