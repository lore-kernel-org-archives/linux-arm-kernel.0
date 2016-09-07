From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:41:04 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.8
Message-ID: <cover.1473232298.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.8.

This relaxes the requirement that all da9xxx devices are added before
the drivers for any are initialised.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.8

for you to fetch changes up to c2f321126e31cd69365e65ecd4a7c774e4fc71d2:

  ARM: shmobile: fix regulator quirk for Gen2 (2016-09-02 10:15:38 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.8

* Correct R-Car Gen2 regulator quirk

----------------------------------------------------------------
Wolfram Sang (1):
      ARM: shmobile: fix regulator quirk for Gen2

 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 62 +++++++++-------------
 1 file changed, 26 insertions(+), 36 deletions(-)
