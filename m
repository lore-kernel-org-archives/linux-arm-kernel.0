From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 10 Feb 2014 18:41:21 +0200
Subject: [PATCH v3 4/4] ARM: keystone_defconfig: enable led support
In-Reply-To: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
References: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1392050481-19086-5-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone GPIO functionality is ready for use, so LED support can be
enabled in config.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/keystone_defconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index f9467ad..7056ef4 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -182,3 +182,11 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DAVINCI=y
+CONFIG_LEDS_CLASS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_GPIO=y
-- 
1.7.9.5
