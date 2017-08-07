From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 22:31:58 +0800
Subject: [PATCH 3/5] arm64: defconfig: enable CONFIG_SYSCON_REBOOT_MODE
In-Reply-To: <20170807143200.6764-1-guodong.xu@linaro.org>
References: <20170807143200.6764-1-guodong.xu@linaro.org>
Message-ID: <20170807143200.6764-4-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_SYSCON_REBOOT_MODE

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d752beb..f7081056 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -298,6 +298,7 @@ CONFIG_GPIO_MAX77620=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
-- 
2.10.2
