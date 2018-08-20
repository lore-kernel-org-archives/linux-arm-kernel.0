From: yannick.fertre@st.com (=?UTF-8?q?Yannick=20Fertr=C3=A9?=)
Date: Mon, 20 Aug 2018 15:46:55 +0200
Subject: [PATCH 1/6] ARM: multi_v7_defconfig: enable backlight gpio
Message-ID: <1534772815-3083-1-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable generic GPIO based backlight driver.

Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 23f5b67..bbd5c8c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -664,6 +664,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
+CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_SOUND=m
-- 
2.7.4
