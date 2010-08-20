From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 20 Aug 2010 20:45:05 +0900
Subject: [GIT PULL] genesis updates for 2.6.36-rc2
Message-ID: <20100820114505.GB30659@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only noteworthy thing here are the runtime PM bits, which were
blocked on the driver core tree merge.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/genesis-2.6.git

Which contains:

Arnd Hannemann (2):
      ARM: mach-shmobile: AP4EVB: use gpio-leds for leds.
      ARM: mach-shmobile: ap4evb: fix write protect for SDHI1

Guennadi Liakhovetski (2):
      ARM: mach-shmobile: add clock definitions for CEU and CSI2
      ARM: mach-shmobile: do not enable the PLLC2 clock on init

Kuninori Morimoto (1):
      ARM: mach-shmobile: ap4evb: modify FSI2 ID

Magnus Damm (2):
      ARM: mach-shmobile: Runtime PM V3
      ARM: mach-shmobile: Clock framework comment fix

Paul Mundt (1):
      ARM: mach-shmobile: Fix up gpio-leds pdata definition.

 arch/arm/mach-shmobile/Makefile       |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c |   56 ++++++++---
 arch/arm/mach-shmobile/clock-sh7372.c |    9 +-
 arch/arm/mach-shmobile/clock.c        |    4 +-
 arch/arm/mach-shmobile/pm_runtime.c   |  169 +++++++++++++++++++++++++++++++++
 5 files changed, 220 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm_runtime.c
