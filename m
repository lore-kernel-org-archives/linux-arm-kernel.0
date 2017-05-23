From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 23 May 2017 17:46:57 +0200
Subject: [PATCH] ARM: davinci_all_defconfig: Enable CPPI 4.1 USB OTG DMA
Message-ID: <20170523154657.22696-1-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPPI 4.1 DMA is now supported on AM18xx.
Update the config to use it instead of PIO mode.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67db829..2fd4bb1 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -174,7 +174,7 @@ CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_DA8XX=m
-CONFIG_MUSB_PIO_ONLY=y
+CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TEST=m
 CONFIG_NOP_USB_XCEIV=m
 CONFIG_USB_GADGET=m
-- 
2.10.2
