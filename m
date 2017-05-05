From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 5 May 2017 17:31:26 +0200
Subject: [PATCH v5 7/8] ARM: configs: stm32: STMPE1600 GPIO expander
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1493998287-5828-8-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable STMPE1600 GPIO expander.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/configs/stm32_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..84adc88 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -49,6 +49,8 @@ CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
+CONFIG_GPIO_STMPE=y
+CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
-- 
1.9.1
