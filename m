From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Jul 2014 08:55:47 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Defconfig Updates
 for v3.17
Message-ID: <cover.1405640905.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC defconfig
updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig3-for-v3.17,
which you have merged into renesas/defconfig3.

I will follow-up with a pull request that removes
the Genmai board code.


The following changes since commit 8cbf869a0a278c4d39e50daa4f4101b394a72a93:

  ARM: shmobile: Enable R-Car Gen 2 PCIe in shmobile_defconfig (2014-07-09 10:44:12 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig4-for-v3.17

for you to fetch changes up to 92db2b7af591d3c3212183a34856b4cb190b6999:

  ARM: shmobile: defconfig: Remove MACH_GENMAI (2014-07-17 00:02:34 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Defconfig Updates for v3.17

The genmai board code is going away so remove:
* The genmai defconfig
* MACH_GENMAI from shmobile defconfig

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: defconfig: Remove MACH_GENMAI

Simon Horman (1):
      ARM: shmobile: genmai: remove defconfig

 arch/arm/configs/genmai_defconfig   | 122 ------------------------------------
 arch/arm/configs/shmobile_defconfig |   1 -
 2 files changed, 123 deletions(-)
 delete mode 100644 arch/arm/configs/genmai_defconfig
