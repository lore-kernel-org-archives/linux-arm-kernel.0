From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 11:55:52 +0100
Subject: [PATCH v3 5/5] ARM: sunxi: Enable A31 SPI and SID in the defconfig
In-Reply-To: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391165752-1819-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sunxi_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3e2259b..b5df4a5 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -24,6 +24,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EEPROM_SUNXI_SID=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 # CONFIG_NET_CADENCE is not set
@@ -48,6 +49,8 @@ CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
+CONFIG_SPI=y
+CONFIG_SPI_SUN6I=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
-- 
1.8.4.2
