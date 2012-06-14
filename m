From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:51:06 +0200
Subject: [PATCH v2 16/23] ARM: LPC32xx: Build arch dtbs
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-17-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Add ea3250.dtb and phy3250.dtb to the list of dtbs to be built

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/Makefile.boot |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/Makefile.boot
+++ linux-2.6/arch/arm/mach-lpc32xx/Makefile.boot
@@ -2,3 +2,4 @@
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x82000000
 
+dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
