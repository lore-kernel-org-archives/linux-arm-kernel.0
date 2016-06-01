From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  1 Jun 2016 10:54:56 +0200
Subject: [PATCH] ARM: defconfig: enable the MSM8660 pin controller
Message-ID: <1464771296-8329-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enabling this I get pins, GPIO, keys and everything on
the MSM8660 surf (APQ8660 DragonBoard).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 7bff7bf24a85..dddb917f7ea9 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -103,6 +103,7 @@ CONFIG_SPMI=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ8064=y
+CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
 CONFIG_PINCTRL_MSM8X74=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-- 
2.4.11
