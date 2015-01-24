From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 24 Jan 2015 16:05:03 +0100
Subject: [PATCH v4 4/4] MAINTAINERS: add entry for lubbock-cplds
In-Reply-To: <1422111903-22176-1-git-send-email-robert.jarzmik@free.fr>
References: <1422111903-22176-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1422111903-22176-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry Lubbock cplds driver into the pxa platform scope.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..8c6a49d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7681,6 +7681,7 @@ T:	git git://github.com/hzhuang1/linux.git
 T:	git git://github.com/rjarzmik/linux.git
 S:	Maintained
 F:	arch/arm/mach-pxa/
+F:	drivers/mfd/lubbock.c
 F:	drivers/pcmcia/pxa2xx*
 F:	drivers/spi/spi-pxa2xx*
 F:	drivers/usb/gadget/udc/pxa2*
-- 
2.1.0
