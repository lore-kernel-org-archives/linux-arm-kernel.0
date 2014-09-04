From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:50 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a7740 Multiplatform Updates for
 v3.18
Message-ID: <cover.1409792648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7740 multiplatform updates
for v3.18.

This pull request is based on
"Renesas ARM Based SoC R8a7740 CCF and Timers Updates for v3.18"
tagged as renesas-r8a7740-ccf-and-timers-for-v3.18,
which I have previously sent a pull request for.


The following changes since commit 433306747791845677ba662435a9bbbafaa21df3:

  ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt (2014-08-23 19:58:57 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7740-multiplatform-for-v3.18

for you to fetch changes up to 118a04358b7efa884aeedf80ddecc87174d7f3c2:

  ARM: shmobile: armadillo800eva reference: Remove DTS (2014-09-02 10:04:32 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a7740 Multiplatform Updates for v3.18

* Enable multiplatform support for r8a7740 SoC and remove
  its DT-reference C board DTS files.

118a043 ARM: shmobile: armadillo800eva reference: Remove DTS
f2d4c4a ARM: shmobile: armadillo800eva reference: Remove C board code
1174c71 ARM: shmobile: r8a7740: Add restart callback
cc9517d ARM: shmobile: armadillo800eva: Build DTS for multiplatform
25aa7ba ARM: shmobile: armadillo800eva: Sync DTS
c41215b ARM: shmobile: r8a7740: Multiplatform support

----------------------------------------------------------------
Magnus Damm (6):
      ARM: shmobile: r8a7740: Multiplatform support
      ARM: shmobile: armadillo800eva: Sync DTS
      ARM: shmobile: armadillo800eva: Build DTS for multiplatform
      ARM: shmobile: r8a7740: Add restart callback
      ARM: shmobile: armadillo800eva reference: Remove C board code
      ARM: shmobile: armadillo800eva reference: Remove DTS

 arch/arm/boot/dts/Makefile                         |   2 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 300 ---------------------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      | 276 ++++++++++++++++++-
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 .../board-armadillo800eva-reference.c              | 199 --------------
 arch/arm/mach-shmobile/pm-r8a7740.c                |   5 +-
 arch/arm/mach-shmobile/r8a7740.h                   |   4 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  16 +-
 8 files changed, 300 insertions(+), 507 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c
