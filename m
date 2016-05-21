From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:37 +0200
Subject: [PATCH 0109/1529] Fix typo
Message-ID: <20160521115037.5020-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-pxa/cm-x2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index 7202022..c293d1b 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -385,7 +385,7 @@ static int __init cmx2xx_set_display(char *str)
    frame buffer.
    Indeed, pxafb parameters can be used istead, but CM-X2XX bootloader
    has limitied line length for kernel command line, and also it will
-   break compatibitlty with proprietary releases already in field.
+   break compatibility with proprietary releases already in field.
 */
 __setup("monitor=", cmx2xx_set_display);
 
-- 
2.8.2.534.g1f66975
