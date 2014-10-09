From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 9 Oct 2014 15:44:30 -0700
Subject: [PATCH V4 6/7] MAINTAINERS: Entry for Cygnus/iproc arm architecture
 and clock drivers
In-Reply-To: <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1412894671-5921-7-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jonathan Richardson <jonathar@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 MAINTAINERS |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a12edf2..0900082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2071,9 +2071,24 @@ L:	linux-scsi at vger.kernel.org
 S:	Supported
 F:	drivers/scsi/bnx2i/
 
-BROADCOM KONA GPIO DRIVER
+BROADCOM CYGNUS/IPROC ARM ARCHITECTURE
 M:	Ray Jui <rjui@broadcom.com>
+M:	Scott Branden <sbranden@broadcom.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	bcm-kernel-feedback-list at broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/bcm/cygnus.txt
+F:	arch/arm/boot/dts/bcm-cygnus.dtsi
+F:	arch/arm/boot/dts/bcm911360_entphn.dts
+F:	arch/arm/configs/bcm_cygnus_defconfig
+F:	arch/arm/mach-bcm/bcm_cygnus.c
+F:	Documentation/devicetree/bindings/clock/clk-cygnus.txt
+F:	Documentation/devicetree/bindings/clock/clk-iproc.txt
+F:	drivers/clk/bcm/clk-cygnus.c
+F:	drivers/clk/bcm/clk-iproc.c
+
+BROADCOM KONA GPIO DRIVER
+M:	Ray Jui <rjui@broadcom.com>
 S:	Supported
 F:	drivers/gpio/gpio-bcm-kona.c
 F:	Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
-- 
1.7.9.5
