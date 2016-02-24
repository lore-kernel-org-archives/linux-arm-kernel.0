From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 24 Feb 2016 15:57:47 +0100
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Enable initramfs support
In-Reply-To: <1456325867-5309-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456325867-5309-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1456325867-5309-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

This makes it possible to automatically boot-test this defconfig with
kernelci.org.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index f23b3ba..cb7b0f5 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -6,6 +6,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
-- 
2.7.0
