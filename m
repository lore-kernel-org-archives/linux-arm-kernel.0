From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 22 Feb 2012 17:15:26 +0100
Subject: [PATCH 1/2] ARM: at91: add at91sam9g25ek.dts in Makefile.boot
In-Reply-To: <1329927327-10613-1-git-send-email-nicolas.ferre@atmel.com>
References: <5a6951fcbe28c3093c936d40c4b28f7ae3161d8d.1329903206.git.nicolas.ferre@atmel.com>
 <1329927327-10613-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <76d3abda7e00e0bd2c8b42b2cf87ff8da16314c0.1329926750.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Makefile.boot |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 2fd051e..be7200b 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -14,3 +14,4 @@ initrd_phys-y	:= 0x20410000
 endif
 
 dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9m10g45ek.dtb usb_a9g20.dtb
+dtb-$(CONFIG_MACH_AT91SAM_DT) += at91sam9g25ek.dtb
-- 
1.7.9
