From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 5 May 2017 17:31:27 +0200
Subject: [PATCH v5 8/8] ARM: configs: stm32: DCMI + OV2640 camera support
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1493998287-5828-9-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DCMI camera interface and OV2640 camera sensor drivers.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/configs/stm32_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 84adc88..3f2e4ce 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -53,6 +53,13 @@ CONFIG_GPIO_STMPE=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_VIDEO_V4L2=y
+CONFIG_MEDIA_SUBDRV_AUTOSELECT=n
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_VIDEO_STM32_DCMI=y
+CONFIG_VIDEO_OV2640=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
1.9.1
