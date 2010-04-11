From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 11 Apr 2010 14:54:31 +0200
Subject: [PATCH] MX2: devices.c: Fix typo in imx21 usb mem resource address
Message-ID: <1270990471-28137-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-mx2/devices.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index b91e412..67182e1 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -483,8 +483,8 @@ int __init mxc_register_gpios(void)
 #ifdef CONFIG_MACH_MX21
 static struct resource mx21_usbhc_resources[] = {
 	{
-		.start	= MX21_BASE_ADDR,
-		.end	= MX21_BASE_ADDR + 0x1FFF,
+		.start	= MX21_USBOTG_BASE_ADDR,
+		.end	= MX21_USBOTG_BASE_ADDR + 0x1FFF,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-- 
1.5.6.5
