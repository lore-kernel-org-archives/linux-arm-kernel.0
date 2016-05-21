From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:02 +0200
Subject: [PATCH 0113/1529] Fix typo
Message-ID: <20160521115102.5231-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-pxa/trizeps4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index ea78bc5..ce913fe 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -55,7 +55,7 @@
 
 /*	comment out the following line if you want to use the
  *	Standard UART from PXA for serial / irda transmission
- *	and acivate it if you have status leds connected */
+ *	and activate it if you have status leds connected */
 #define STATUS_LEDS_ON_STUART_PINS 1
 
 /*****************************************************************************
-- 
2.8.2.534.g1f66975
