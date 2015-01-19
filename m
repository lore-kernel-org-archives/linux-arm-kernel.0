From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 15:45:01 -0600
Subject: [PATCH] MAINTAINERS: add omap2plus_defconfig under OMAP SUPPORT
Message-ID: <1421703901-28295-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap2plus_defconfig is also part of the OMAP Support
maintained, because of that it's best to list it
under OMAP SUPPORT on MAINTAINERS so people know
to Cc linux-omap when patching that file.

Reported-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97de006f38f0..abc6281892e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6783,6 +6783,7 @@ Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 S:	Maintained
 F:	arch/arm/*omap*/
+F:	arch/arm/configs/omap2plus_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
-- 
2.2.0
