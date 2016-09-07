From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:41:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.9
Message-ID: <cover.1473233986.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.9.


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.9

for you to fetch changes up to 82acc69402d91bde8657c0db26e5211943de65fd:

  ARM: shmobile: r8a7791: only use smp_init when SMP is selected (2016-08-24 09:08:57 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.9

Clean-up:
* Only use smp_init when SMP is selected

Enablement:
* Add debug-ll support for r8a7992

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: debug-ll: Add support for r8a7992

Wolfram Sang (2):
      ARM: shmobile: r8a7790: only use smp_init when SMP is selected
      ARM: shmobile: r8a7791: only use smp_init when SMP is selected

 arch/arm/Kconfig.debug                 | 8 ++++----
 arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
