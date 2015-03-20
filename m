From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:15 +0900
Subject: [GIT PULL] Renesas ARM Based SoC PM Updates for v4.1
Message-ID: <cover.1426812951.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC PM updates for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pm-for-v4.1

for you to fetch changes up to a8caad66904a7923c05fc4a137110085533ef00c:

  ARM: shmobile: Consolidate the pm code for R-Car Gen2 (2015-03-17 08:05:13 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC PM Updates for v4.1

* Consolidate the pm code for R-Car Gen2
* Correct SYSCIER value for r8a7790 and r8a7791 SoCs

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: Consolidate the pm code for R-Car Gen2

Simon Horman (2):
      ARM: shmobile: r8a7790: Correct SYSCIER value
      ARM: shmobile: r8a7791: Correct SYSCIER value

 arch/arm/mach-shmobile/Makefile       |   5 +-
 arch/arm/mach-shmobile/pm-r8a7790.c   |  82 ------------------------
 arch/arm/mach-shmobile/pm-r8a7791.c   |  73 ---------------------
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 115 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/r8a7790.h      |   1 -
 arch/arm/mach-shmobile/r8a7791.h      |   1 -
 arch/arm/mach-shmobile/rcar-gen2.h    |   1 +
 arch/arm/mach-shmobile/smp-r8a7790.c  |   3 +-
 arch/arm/mach-shmobile/smp-r8a7791.c  |   2 +-
 9 files changed, 122 insertions(+), 161 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7791.c
 create mode 100644 arch/arm/mach-shmobile/pm-rcar-gen2.c
