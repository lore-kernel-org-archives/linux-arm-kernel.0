From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:38 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup Updates for v3.16
Message-ID: <cover.1398216284.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup updates for v3.16.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.16

for you to fetch changes up to bb6c3d58c36adb205b4bf233fd1c4079e02a6811:

  ARM: shmobile: r8a7740: Make r8a7740_meram_workaround() __init (2014-04-16 10:01:49 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup Updates for v3.16

r8a7740 (R-Mobile A1) SoC
* Make r8a7740_meram_workaround() __init
* Remove unused r8a7740_add_early_devices_dt()

r8a7740 (R-Mobile A1) based Armadillo800 EVA board
* Spelling and grammar fixes

sh7372 (SH-Mobile AP4) SoC
* Call sh7372_add_early_devices() instead of open coding

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: armadillo800eva: Spelling and grammar
      ARM: shmobile: r8a7740: Remove unused r8a7740_add_early_devices_dt()
      ARM: shmobile: sh7372: Call sh7372_add_early_devices() instead of open coding
      ARM: shmobile: r8a7740: Make r8a7740_meram_workaround() __init

 arch/arm/mach-shmobile/Kconfig         |  4 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c | 13 +------------
 arch/arm/mach-shmobile/setup-sh7372.c  |  6 +-----
 3 files changed, 4 insertions(+), 19 deletions(-)
