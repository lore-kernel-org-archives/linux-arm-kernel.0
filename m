From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:42 +0200
Subject: [PATCH 0101/1529] Fix typo
Message-ID: <20160521114942.4603-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-mmp/pxa168.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0f5f16f..e37dfd7 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -133,7 +133,7 @@ struct platform_device pxa168_device_gpio = {
 };
 
 struct resource pxa168_usb_host_resources[] = {
-	/* USB Host conroller register base */
+	/* USB Host controller register base */
 	[0] = {
 		.start	= PXA168_U2H_REGBASE + U2x_CAPREGS_OFFSET,
 		.end	= PXA168_U2H_REGBASE + USB_REG_RANGE,
-- 
2.8.2.534.g1f66975
