From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:56:59 +0200
Subject: [PATCH 4/4] ARM: mvebu: add gpio-fan to mvebu_v7_defconfig
In-Reply-To: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1410429419-29820-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since one of the platforms (Armada 370 RD) is now using the gpio-fan
driver, it makes sense to enable it in mvebu_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 3469c3d9..61ef899 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -77,6 +77,7 @@ CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_SOUND=y
-- 
2.0.0
