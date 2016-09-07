From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  7 Sep 2016 19:50:28 +0800
Subject: [PATCH 2/2] arm64: defconfig: enable MFD RK808 and RK808 regulator
In-Reply-To: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
References: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1473249028-27161-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many rockchip based arm64 boards use RK808 as PMIC, so
enabe it here let the board bootup normally.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 427b6dc..4b61ed9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -258,6 +258,7 @@ CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_MAX77620=y
+CONFIG_MFD_RK808=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_HI655X_PMIC=y
@@ -270,6 +271,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
+CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_DRM=m
 CONFIG_DRM_NOUVEAU=m
-- 
2.7.4
