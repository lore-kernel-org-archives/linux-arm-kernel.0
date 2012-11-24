From: cesarb@cesarb.net (Cesar Eduardo Barros)
Date: Fri, 23 Nov 2012 22:26:29 -0200
Subject: [PATCH 05/24] MAINTAINERS: fix
 arch/arm/mach-at91/include/mach/at_hdmac.h
In-Reply-To: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Message-ID: <1353716808-16375-6-git-send-email-cesarb@cesarb.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file was moved to include/linux/platform_data/dma-atmel.h by commit
7cdc39e (ARM: at91: move platform_data definitions).

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c67b991..dd28c70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1389,7 +1389,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
-F:	arch/arm/mach-at91/include/mach/at_hdmac.h
+F:	include/linux/platform_data/dma-atmel.h
 
 ATMEL ISI DRIVER
 M:	Josh Wu <josh.wu@atmel.com>
-- 
1.7.11.7
