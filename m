From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Jul 2013 21:49:53 +0530
Subject: [GIT PULL] DaVinci fixes for v3.11-rc2
Message-ID: <51E572A9.2080201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following fixes for v3.11-rc2?

Thanks,
Sekhar

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.11-rc2

for you to fetch changes up to cf690331642010a837c026088588761f61528ddf:

  ARM: davinci: defconfig: enable EDMA driver (2013-07-16 20:39:39 +0530)

----------------------------------------------------------------
DaVinci fixes for v3.11-rc2

The pull request includes fixes for sparse
warnings, defconfig changes to enable DMA
usage on peripherals and removal of a duplicated
include file.

----------------------------------------------------------------
Sekhar Nori (2):
      ARM: davinci: make file local variables static
      ARM: davinci: defconfig: enable EDMA driver

Wei Yongjun (1):
      ARM: edma: remove duplicated include from edma.c

 arch/arm/common/edma.c                  |    1 -
 arch/arm/configs/da8xx_omapl_defconfig  |    2 ++
 arch/arm/configs/davinci_all_defconfig  |    2 ++
 arch/arm/mach-davinci/board-dm365-evm.c |    2 +-
 arch/arm/mach-davinci/dm355.c           |    2 +-
 arch/arm/mach-davinci/dm365.c           |    2 +-
 6 files changed, 7 insertions(+), 4 deletions(-)
