From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 25 May 2015 23:29:19 +0200
Subject: [PATCH v4 2/5] MAINTAINERS: add pxa dma driver to pxa architecture
In-Reply-To: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
References: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1432589362-23241-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pxa dma driver as maintained by the pxa architecture
maintainers, as it is part of the core IP.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76a40..35062a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7873,6 +7873,7 @@ T:	git git://github.com/hzhuang1/linux.git
 T:	git git://github.com/rjarzmik/linux.git
 S:	Maintained
 F:	arch/arm/mach-pxa/
+F:	drivers/dma/pxa*
 F:	drivers/pcmcia/pxa2xx*
 F:	drivers/spi/spi-pxa2xx*
 F:	drivers/usb/gadget/udc/pxa2*
-- 
2.1.4
