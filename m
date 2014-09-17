From: b38343@freescale.com (Robin Gong)
Date: Wed, 17 Sep 2014 17:58:00 +0800
Subject: [PATCH v3 3/3] ARM: configs: imx_v6_v7_defconfig: add power off driver
In-Reply-To: <1410947881-7345-1-git-send-email-b38343@freescale.com>
References: <1410947881-7345-1-git-send-email-b38343@freescale.com>
Message-ID: <1410947881-7345-4-git-send-email-b38343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power off driver in config file.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 16cfec4..a310e61 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -165,6 +165,9 @@ CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_STMPE=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_IMX=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
-- 
1.7.9.5
