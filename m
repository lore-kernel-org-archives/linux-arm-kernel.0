From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  9 Jul 2015 17:43:26 +0200
Subject: [PATCH 3/3] ARM: ep93xx: add framebuffer to the defconfig
Message-ID: <1436456606-4963-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx SoC has a framebuffer driver, let's add this to the
defconfig so we can have graphics working out of the box.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/ep93xx_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index e684386e97ba..a7846d64b396 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -90,6 +90,10 @@ CONFIG_SPI=y
 CONFIG_SPI_EP93XX=y
 CONFIG_WATCHDOG=y
 CONFIG_EP93XX_WATCHDOG=y
+CONFIG_FB=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_EP93XX=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.4.3
