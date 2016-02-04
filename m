From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:34 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.6
Message-ID: <cover.1454595116.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.6.

These are all minor cleanups from Geert.


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v4.6

for you to fetch changes up to 2c7bdcfd8912ce47d8360017265713c5a110b9ed:

  ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code (2016-02-02 15:06:30 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.6

* Remove remnants of removed SCU boot setup code for r8a7779
* Correct s/MIPDR/MPIDR/ typo
* Add includes providing forward declarations
* Make rcar_gen2_dma_contiguous static

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: rcar-gen2: Make rcar_gen2_dma_contiguous static
      ARM: shmobile: Add includes providing forward declarations
      ARM: shmobile: Typo s/MIPDR/MPIDR/
      ARM: shmobile: r8a7779: Remove remainings of removed SCU boot setup code

 arch/arm/mach-shmobile/cpufreq.c         | 2 ++
 arch/arm/mach-shmobile/headsmp-scu.S     | 2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 7 ++++---
 arch/arm/mach-shmobile/smp-r8a7779.c     | 2 --
 arch/arm/mach-shmobile/suspend.c         | 2 ++
 arch/arm/mach-shmobile/timer.c           | 2 ++
 6 files changed, 11 insertions(+), 6 deletions(-)
