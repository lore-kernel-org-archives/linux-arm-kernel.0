From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  2 Jun 2014 11:58:55 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Zynq cpuidle driver
Message-ID: <1401735535-13692-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
I overlooked this one when I enabled the peripheral drivers the other day.

	S?ren
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..311c16243750 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -80,6 +80,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.0.0
