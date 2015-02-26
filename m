From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:32 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.1
Message-ID: <cover.1424931049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-cleanup-for-v4.1

for you to fetch changes up to fd9454ab51fa92f43ae5b7a71c42f2ee8417c2a2:

  ARM: shmobile: r8a7779: Remove redundant cpu_disable implementation (2015-02-24 07:12:16 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v4.1

* Remove redundant cpu_disable implementation from r8a7779 SoC
* Remove mach/{uncompress,clkdev,system}.h

----------------------------------------------------------------
Magnus Damm (3):
      ARM: shmobile: Remove mach/system.h
      ARM: shmobile: Remove mach/clkdev.h
      ARM: shmobile: Remove mach/uncompress.h

Stephen Boyd (1):
      ARM: shmobile: r8a7779: Remove redundant cpu_disable implementation

 arch/arm/Kconfig                                 |  1 -
 arch/arm/Kconfig.debug                           |  3 ++-
 arch/arm/mach-shmobile/clock.c                   | 11 -----------
 arch/arm/mach-shmobile/include/mach/clkdev.h     |  7 -------
 arch/arm/mach-shmobile/include/mach/system.h     | 11 -----------
 arch/arm/mach-shmobile/include/mach/uncompress.h | 19 -------------------
 arch/arm/mach-shmobile/smp-r8a7779.c             |  7 -------
 7 files changed, 2 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/clkdev.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/system.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/uncompress.h
