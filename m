From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 18:41:27 -0400
Subject: [PATCH v2 5/5] ARM: keystone: Enable I2C and SPI bus support
In-Reply-To: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380580887-24249-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone I2C dnd SPI driver updates are already merged so lets
enable them in config.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/keystone_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 1f36b82..9943e5d 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -123,7 +123,9 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DAVINCI=y
 CONFIG_SPI=y
+CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-- 
1.7.9.5
