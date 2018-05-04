From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 4 May 2018 14:46:55 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add STM32F7 I2C & STM32 USBPHYC
 support
Message-ID: <1525438015-15834-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds STM32F7 I2C support to multi_v7_defconfig and
enable the STM32 USB PHY Controller (USBPHYC) driver, implemented on
STM32MP1 SoC.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Hi Arnd, Kevin and Olof,

I just have this patch for STM32 configs update, so please consider it as my
STM32 defconfig pull request for v4.18.

Thanks

Alex


diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..9d0856e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -385,6 +385,7 @@ CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_ST=y
+CONFIG_I2C_STM32F7=y
 CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER=y
@@ -972,6 +973,7 @@ CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH407_USB=y
+CONFIG_PHY_STM32_USBPHYC=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
-- 
2.7.4
