From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 02:03:20 +0100
Subject: [PATCH v3 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that
implements the generic pinctrl dt-bindings") made PINCTRL_MT7622
depend on PINCTRL_MTK_MOORE.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6fe418d72337..725b9471b21c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -369,7 +369,7 @@ CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
-CONFIG_PINCTRL_MT7622=y
+CONFIG_PINCTRL_MTK_MOORE=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
-- 
2.8.2
