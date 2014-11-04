From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:07 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Soc Updates for v3.19
Message-ID: <cover.1415058939.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC soc updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.19

for you to fetch changes up to 3794705aeb318c431c07072f04380c78cc5a84ac:

  ARM: shmobile: Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled (2014-10-28 08:43:03 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Soc Updates for v3.19

* Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled
* Add CA7 arch_timer initialization for r8a7794
* Handle CA7 arch timer delay
* Add shmobile_init_late() to sh7372
  - This is consistent with other shmobile SoCs

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: sh7372: Add shmobile_init_late()

Laurent Pinchart (1):
      ARM: shmobile: Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled

Magnus Damm (1):
      ARM: shmobile: Handle CA7 arch timer delay

Ulrich Hecht (1):
      ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794

 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 72 ++++++++++++++++++++++----------
 arch/arm/mach-shmobile/setup-sh7372.c    |  1 +
 arch/arm/mach-shmobile/timer.c           | 23 ++++++----
 4 files changed, 66 insertions(+), 31 deletions(-)
