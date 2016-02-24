From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 24 Feb 2016 16:03:19 +0100
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: Enable initramfs support
In-Reply-To: <1456326199-12438-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456326199-12438-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1456326199-12438-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

This makes it possible to automatically boot-test this defconfig with
kernelci.org.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/configs/multi_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index fcbc633..ab503c2 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=19
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
-- 
2.7.0
