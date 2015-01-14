From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 Jan 2015 10:54:59 +0100
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic
 (SATA, PCIe & USB3) PHY
In-Reply-To: <1421229299-8206-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1421229299-8206-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1421229299-8206-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4b87fd1..88dfa7e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -459,6 +459,7 @@ CONFIG_PWM_VT8500=y
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_STIH407_USB=y
-- 
1.9.1
