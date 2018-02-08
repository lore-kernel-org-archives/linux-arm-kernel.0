From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 8 Feb 2018 15:27:37 +0100
Subject: [PATCH 6/6] ARM: configs: stm32: enable ST MFX and its GPIO expander
 feature
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518100057-23234-7-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index eb3c2e4..aa9feed 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -52,9 +52,11 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_STM32F4=y
 CONFIG_I2C_STM32F7=y
 CONFIG_GPIO_STMPE=y
+CONFIG_GPIO_ST_MFX=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_MFD_STMPE=y
+CONFIG_MFD_ST_MFX=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
-- 
2.7.4
