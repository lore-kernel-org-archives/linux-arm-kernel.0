From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:43 +0100
Subject: [PATCH 05/19] ARM: multi_v7_defconfig: Remove miphy365 phy.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This IP is only found on STiH415/6 silicon and support
for these SoCs is being removed from the kernel.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665c..949ab7f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -854,7 +854,6 @@ CONFIG_PHY_ROCKCHIP_DP=m
 CONFIG_PHY_ROCKCHIP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
-CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_STIH407_USB=y
-- 
1.9.1
