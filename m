From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 29 Sep 2013 16:40:15 -0300
Subject: [PATCH] ARM: mvebu: config: Add GPIO connected LEDs support to
 defconfig
Message-ID: <1380483615-15899-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost every mvebu board has at least one LED connected to a GPIO
line. Include this in the default configuration.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 594d706..6fcb5c8 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -69,6 +69,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-- 
1.8.1.5
