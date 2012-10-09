From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Oct 2012 11:46:26 -0700
Subject: [GIT PULL 3/5] omap pm fixes for v3.7-rc1
In-Reply-To: <pull-1349808387-617119>
Message-ID: <mailman.20.1349808406.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5e090ed7af10729a396a25df43d69a236e789736:

  Merge tag 'soc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-10-07 20:55:16 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-pm-signed

for you to fetch changes up to fce680e9faaa8acc0ab0a931c5fa823b581cbab0:

  Merge tag 'for_3.7-fixes-pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-pm (2012-10-08 15:57:41 -0700)

----------------------------------------------------------------

>From Kevin Hilman <khilman@deeprootsystems.com>:

OMAP PM related fixes for v3.7-rc

----------------------------------------------------------------
Jean Pihet (2):
      ARM: OMAP: SmartReflex: select CONFIG_POWER_SUPPLY in Kconfig
      ARM: OMAP: SmartReflex: fix error path in init function

Tony Lindgren (1):
      Merge tag 'for_3.7-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-pm

Wei Yongjun (4):
      ARM: OMAP: fix return value check in beagle_opp_init()
      ARM: OMAP: omap_device: fix return value check in omap_device_build_ss()
      ARM: OMAP2+: SmartReflex: fix return value check in sr_dev_init()
      ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()

 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/pm.c                |    2 +-
 arch/arm/mach-omap2/sr_device.c         |    2 +-
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/omap_device.c        |    2 +-
 drivers/power/avs/smartreflex.c         |    8 ++++----
 6 files changed, 9 insertions(+), 8 deletions(-)
