From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 20:28:17 -0400
Subject: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable on
 Keystone SOCs
Message-ID: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone SOCs uses the same I2C IP as available on DaVinci SOCs. These
couple of patches makes it possible to select the I2C_DAVINCI on
Keystone SOCs.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>

Santosh Shilimkar (2):
  i2c: davinci: remove useless mach/hardware include
  i2c: davinci: Allow i2c driver available for keystone platforms

 drivers/i2c/busses/Kconfig       |    2 +-
 drivers/i2c/busses/i2c-davinci.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
1.7.9.5
