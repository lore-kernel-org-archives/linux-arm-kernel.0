From: javi.merino@arm.com (Javi Merino)
Date: Mon, 13 Jun 2016 16:15:14 +0100
Subject: [PATCH 1/2] arm64: defconfig: enable SENSORS_ARM_SCPI
In-Reply-To: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
References: <1465830915-16342-1-git-send-email-javi.merino@arm.com>
Message-ID: <1465830915-16342-2-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM SCPI Sensors were merged for v4.4 and they are defined in the Juno
dts.  Enable it in the defconfig to get them registered automatically in
Juno by default.

Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d0491e..1152c6d9f6e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -197,6 +197,7 @@ CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_INA2XX=m
+CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
-- 
1.9.1
