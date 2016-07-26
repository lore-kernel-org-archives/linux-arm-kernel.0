From: thloh@altera.com (thloh at altera.com)
Date: Mon, 25 Jul 2016 18:43:09 -0700
Subject: [PATCH 1/1] socfpga: defconfig: Enable Altera GPIO driver as module
Message-ID: <1469497389-11322-1-git-send-email-thloh@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tien Hock Loh <thloh@altera.com>

This patch enables Altera GPIO driver as module in socfpga_defconfig

Signed-off-by: Tien Hock Loh <thloh@altera.com>
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 753f1a5..241ce4ca 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -108,3 +108,4 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_ENABLE_DEFAULT_TRACERS=y
 CONFIG_DEBUG_USER=y
+CONFIG_GPIO_ALTERA=m
-- 
1.7.11.GIT
