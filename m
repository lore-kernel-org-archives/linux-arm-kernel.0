From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 20 Oct 2014 16:19:24 +0300
Subject: [PATCH 1/2] ARM: keystone_defconfig: enable dsp irq and gpio support
Message-ID: <1413811165-3928-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DSP IRQ controller and GPIOs support for Keystone 2.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 932ae40..c9b0d1b 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -194,3 +194,5 @@ CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_KEYSTONE_IRQ=y
+CONFIG_GPIO_SYSCON=y
-- 
1.9.1
