From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:34 -0800
Subject: [PATCH 13/14] i2c: Add support for the LPC32XX arch
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-14-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Allow the i2c-pnx driver to be reused with the LPC32xx arch.
Changed menu title to include NXP devices

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 5f318ce..590a441 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -467,8 +467,8 @@ config I2C_PASEMI
 	  Supports the PA Semi PWRficient on-chip SMBus interfaces.
 
 config I2C_PNX
-	tristate "I2C bus support for Philips PNX targets"
-	depends on ARCH_PNX4008
+	tristate "I2C bus support for Philips/NXP devices"
+	depends on ARCH_PNX4008 || ARCH_LPC32XX
 	help
 	  This driver supports the Philips IP3204 I2C IP block master and/or
 	  slave controller
-- 
1.6.6
