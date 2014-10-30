From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 10:50:30 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup for v3.19
Message-ID: <cover.1414629163.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.19

for you to fetch changes up to 335204dfb83b3105cf4a666d1ad024917831cbdc:

  ARM: shmobile: Remove FSF address from copyright headers (2014-10-27 09:48:07 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup for v3.19

* Remove FSF address from copyright headers

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: shmobile: Remove FSF address from copyright headers

 arch/arm/mach-shmobile/board-ape6evm-reference.c | 4 ----
 arch/arm/mach-shmobile/board-ape6evm.c           | 4 ----
 arch/arm/mach-shmobile/board-armadillo800eva.c   | 5 -----
 arch/arm/mach-shmobile/board-bockw-reference.c   | 4 ----
 arch/arm/mach-shmobile/board-bockw.c             | 4 ----
 arch/arm/mach-shmobile/board-koelsch-reference.c | 4 ----
 arch/arm/mach-shmobile/board-koelsch.c           | 4 ----
 arch/arm/mach-shmobile/board-kzm9g-reference.c   | 4 ----
 arch/arm/mach-shmobile/board-kzm9g.c             | 4 ----
 arch/arm/mach-shmobile/board-lager-reference.c   | 4 ----
 arch/arm/mach-shmobile/board-lager.c             | 4 ----
 arch/arm/mach-shmobile/board-mackerel.c          | 4 ----
 arch/arm/mach-shmobile/board-marzen-reference.c  | 4 ----
 arch/arm/mach-shmobile/board-marzen.c            | 4 ----
 arch/arm/mach-shmobile/clock-r8a73a4.c           | 4 ----
 arch/arm/mach-shmobile/clock-r8a7740.c           | 4 ----
 arch/arm/mach-shmobile/clock-r8a7778.c           | 4 ----
 arch/arm/mach-shmobile/clock-r8a7779.c           | 4 ----
 arch/arm/mach-shmobile/clock-r8a7790.c           | 4 ----
 arch/arm/mach-shmobile/clock-r8a7791.c           | 4 ----
 arch/arm/mach-shmobile/clock-sh7372.c            | 4 ----
 arch/arm/mach-shmobile/clock-sh73a0.c            | 4 ----
 arch/arm/mach-shmobile/clock.c                   | 4 ----
 arch/arm/mach-shmobile/console.c                 | 4 ----
 arch/arm/mach-shmobile/headsmp-scu.S             | 5 -----
 arch/arm/mach-shmobile/intc-sh7372.c             | 4 ----
 arch/arm/mach-shmobile/intc-sh73a0.c             | 4 ----
 arch/arm/mach-shmobile/r8a7740.h                 | 4 ----
 arch/arm/mach-shmobile/r8a7778.h                 | 4 ----
 arch/arm/mach-shmobile/setup-emev2.c             | 4 ----
 arch/arm/mach-shmobile/setup-r7s72100.c          | 4 ----
 arch/arm/mach-shmobile/setup-r8a73a4.c           | 4 ----
 arch/arm/mach-shmobile/setup-r8a7740.c           | 4 ----
 arch/arm/mach-shmobile/setup-r8a7778.c           | 4 ----
 arch/arm/mach-shmobile/setup-r8a7779.c           | 4 ----
 arch/arm/mach-shmobile/setup-r8a7790.c           | 4 ----
 arch/arm/mach-shmobile/setup-r8a7791.c           | 4 ----
 arch/arm/mach-shmobile/setup-rcar-gen2.c         | 4 ----
 arch/arm/mach-shmobile/setup-sh7372.c            | 4 ----
 arch/arm/mach-shmobile/setup-sh73a0.c            | 4 ----
 arch/arm/mach-shmobile/sleep-sh7372.S            | 5 -----
 arch/arm/mach-shmobile/smp-emev2.c               | 4 ----
 arch/arm/mach-shmobile/smp-r8a7779.c             | 4 ----
 arch/arm/mach-shmobile/smp-sh73a0.c              | 4 ----
 arch/arm/mach-shmobile/timer.c                   | 5 -----
 45 files changed, 184 deletions(-)
