From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 12 Jan 2018 13:16:05 +0100
Subject: [PATCH 11/14] ARM: configs: stm32: Enable MMC_ARMMMCI support
In-Reply-To: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515759368-16946-12-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Enable MMC_ARMMCI support to add SDIO support for
STM32F4 and STM32F7 SoCs family

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 21b2bf7..8b64a9e 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -56,6 +56,8 @@ CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.9.1
