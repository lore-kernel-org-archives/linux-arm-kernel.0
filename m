From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:47 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.5
Message-ID: <cover.1448585673.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.5.

This pull request includes some minor cleanups and
introduces ARCH_RENESAS as a firs step to migrating away
from ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.5

for you to fetch changes up to c8cd74a1468ffe20db3ddc6e6f408d5377f9be43:

  ARM: shmobile: Remove legacy mach/irqs.h (2015-11-19 16:28:01 -0800)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.5

* Remove now unnecessary header
* Introduce ARCH_RENESAS
* Remove unmaintened URL from MAINTAINERS

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: Remove legacy mach/irqs.h

Simon Horman (2):
      MAINTAINERS: Remove link to oss.renesas.com which is closed
      ARM: shmobile: Introduce ARCH_RENESAS

 MAINTAINERS                                |  1 -
 arch/arm/configs/multi_v7_defconfig        |  2 +-
 arch/arm/configs/shmobile_defconfig        |  2 +-
 arch/arm/mach-shmobile/Kconfig             | 10 +++++++---
 arch/arm/mach-shmobile/include/mach/irqs.h | 10 ----------
 arch/arm/mach-shmobile/irqs.h              | 15 ---------------
 arch/arm/mach-shmobile/setup-r8a7778.c     |  1 -
 7 files changed, 9 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shmobile/irqs.h
