From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:16:09 +0200
Subject: [PATCH 1/10] IXP4xx: Fix Goramo MultiLink platform compilation.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3obl030xi.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -15,6 +15,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/pci.h>
+#include <asm/system_info.h>
 
 #define SLOT_ETHA		0x0B	/* IDSEL = AD21 */
 #define SLOT_ETHB		0x0C	/* IDSEL = AD20 */

-- 
Krzysztof Halasa
