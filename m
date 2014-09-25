From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Thu, 25 Sep 2014 18:34:47 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: Add Support for QCOM APQ8074 reset
Message-ID: <1411650287-15947-1-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds support for reset driver for apq8074 based platform.
With this we should be able to reboot the board from command prompt.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1bf198b..4f78491 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -230,6 +230,7 @@ CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
 CONFIG_POWER_RESET_SUN6I=y
+CONFIG_POWER_RESET_MSM=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
-- 
1.7.9.5
