From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:48 +0100
Subject: [PATCH 1/6] MAINTAINERS: add to pxa files pinctrl
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1448129093-20722-2-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pinctrl pxa drivers to the pxa maintained files.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b28828..9bca217c655e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8613,6 +8613,7 @@ S:	Maintained
 F:	arch/arm/mach-pxa/
 F:	drivers/dma/pxa*
 F:	drivers/pcmcia/pxa2xx*
+F:	drivers/pinctrl/pxa/
 F:	drivers/spi/spi-pxa2xx*
 F:	drivers/usb/gadget/udc/pxa2*
 F:	include/sound/pxa2xx-lib.h
-- 
2.1.4
