From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 14 Oct 2014 19:58:55 -0700
Subject: [PATCH v5 5/6] MAINTAINERS: Entry for Cygnus/iproc arm architecture
In-Reply-To: <1413341936-17606-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1413341936-17606-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1413341936-17606-6-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jonathan Richardson <jonathar@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 MAINTAINERS |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee1bc5b..794804a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2125,6 +2125,21 @@ L:	linux-scsi at vger.kernel.org
 S:	Supported
 F:	drivers/scsi/bnx2i/
 
+BROADCOM CYGNUS/IPROC ARM ARCHITECTURE
+M:	Ray Jui <rjui@broadcom.com>
+M:	Scott Branden <sbranden@broadcom.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	bcm-kernel-feedback-list at broadcom.com
+T:	git git://git.github.com/brcm/linux.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/bcm/cygnus.txt
+F:	Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
+F:	arch/arm/boot/dts/*cygnus*
+F:	arch/arm/boot/dts/bcm9113*
+F:	arch/arm/boot/dts/bcm9583*
+F:	arch/arm/configs/bcm_cygnus_defconfig
+F:	arch/arm/mach-bcm/bcm_cygnus.c
+
 BROADCOM KONA GPIO DRIVER
 M:	Ray Jui <rjui@broadcom.com>
 L:	bcm-kernel-feedback-list at broadcom.com
-- 
1.7.9.5
