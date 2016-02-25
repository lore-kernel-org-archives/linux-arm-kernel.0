From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 25 Feb 2016 12:24:00 +0100
Subject: [PATCH v2 2/2] ARM: mxs_defconfig: Enable initramfs support
In-Reply-To: <1456399440-3646-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456399440-3646-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1456399440-3646-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

This makes it possible to automatically boot-test this defconfig with
kernelci.org.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/configs/mxs_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 3bd7cad..6c2550e 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -12,6 +12,7 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
-- 
2.7.0
