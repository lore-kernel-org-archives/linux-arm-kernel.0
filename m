From: lee@kernel.org (Lee Jones)
Date: Thu, 14 May 2015 10:25:43 +0100
Subject: RaspberryPi SoC (mach) changes due for v4.2
Message-ID: <20150514092543.GF22418@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM-SoC Chaps,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-soc-for-armsoc-v4.2

for you to fetch changes up to 33a9f5bc1547b563b072b8ac1c453d861aeef0b8:

  ARM: bcm2835: Move the restart/power_off handling to the WDT driver (2015-05-14 10:04:19 +0100)

----------------------------------------------------------------
RaspberryPi SoC (mach) changes due for v4.2

----------------------------------------------------------------
Eric Anholt (3):
      ARM: bcm2835: Skip doing our own iotable_init() initialization
      ARM: bcm2835: Drop the init_irq() hook
      ARM: bcm2835: Move the restart/power_off handling to the WDT driver

 arch/arm/mach-bcm/board_bcm2835.c | 91 ---------------------------------------
 drivers/watchdog/bcm2835_wdt.c    | 62 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 91 deletions(-)
