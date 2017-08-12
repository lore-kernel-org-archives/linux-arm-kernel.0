From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 12 Aug 2017 11:10:43 +0530
Subject: [PATCH 3/3] arm64: defconfig: Enable CONFIG_REGULATOR_AXP20X
In-Reply-To: <1502516443-4740-1-git-send-email-jteki@openedev.com>
References: <1502516443-4740-1-git-send-email-jteki@openedev.com>
Message-ID: <1502516443-4740-3-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

X-POWERS AXP20X PMIC Regulators is need for sunxi a64
so make it default in defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a11fce7..d8f23c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -323,6 +323,7 @@ CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.7.4
