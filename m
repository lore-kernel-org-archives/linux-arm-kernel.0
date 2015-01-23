From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Jan 2015 17:17:41 +0800
Subject: [GIT PULL 3/3] ARM: imx: defconfig update for 3.20
Message-ID: <20150123091740.GD27337@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-3.20

for you to fetch changes up to ec800d7906df7b24b0706da0013a2f83b4d4efe8:

  ARM: imx_v6_v7_defconfig: enable more USB functions (2015-01-20 16:11:06 +0800)

----------------------------------------------------------------
The i.MX defconfig update for 3.20:
 - Eneable FB_MXS, SPI_FSL_QUADSPI, POWER_RESET_SYSCON and module build
   for a bunch of USB functions

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select SPI_FSL_QUADSPI by default
      ARM: imx_v6_v7_defconfig: Select CONFIG_FB_MXS

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: enable more USB functions

Stefan Agner (1):
      ARM: imx_v6_v7_defconfig: add POWER_RESET_SYSCON

 arch/arm/configs/imx_v6_v7_defconfig | 39 ++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)
