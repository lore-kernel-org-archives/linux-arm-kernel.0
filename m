From: andy.gross@linaro.org (Andy Gross)
Date: Mon,  2 Jan 2017 14:35:05 -0600
Subject: [PATCH] ARM: multi_v7_defconfig: enable Qualcomm RPMCC
Message-ID: <1483389305-8283-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the Qualcomm RPM based Clock Controller present on
A-family boards.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a438..4ff6779 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -824,6 +824,7 @@ CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_CLK_RPM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
-- 
1.9.1
