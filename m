From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:59:24 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v3.20
Message-ID: <cover.1421379958.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v3.20.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v3.20,
which you have already pulled.


The following changes since commit 39695882d3d642a73bca551e682426e4e3bcd158:

  ARM: shmobile: r8a73a4: Multiplatform support (2014-12-21 17:11:22 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.20

for you to fetch changes up to 2173fc7cb681c38b9e5bc526211045caecf96e44:

  ARM: shmobile: R-Mobile: Add DT support for PM domains (2015-01-15 08:38:14 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.20

* Add DT support for PM domains

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: R-Mobile: Use generic_pm_domain.attach_dev() for pm_clk setup
      ARM: shmobile: R-Mobile: Store SYSC base address in rmobile_pm_domain
      ARM: shmobile: R-Mobile: Add DT support for PM domains

 arch/arm/mach-shmobile/Kconfig      |   3 +-
 arch/arm/mach-shmobile/pm-r8a7740.c |  14 ++
 arch/arm/mach-shmobile/pm-rmobile.c | 275 ++++++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/pm-rmobile.h |   3 +-
 arch/arm/mach-shmobile/pm-sh7372.c  |  11 ++
 5 files changed, 289 insertions(+), 17 deletions(-)
