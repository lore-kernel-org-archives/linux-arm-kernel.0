From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 24 Feb 2016 16:04:51 +0100
Subject: [PATCH 2/2] ARM: mxs_defconfig: Enable initramfs support
In-Reply-To: <1456326291-20618-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1456326291-20618-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1456326291-20618-2-git-send-email-m.grzeschik@pengutronix.de>
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
index 5e7b7df..dc498cd 100644
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
