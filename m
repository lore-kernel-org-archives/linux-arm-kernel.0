From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 12:29:26 -0800
Subject: [PATCH 7/7] MAINTAINERS: Update brcmstb entries to cover B15 code
In-Reply-To: <20170118202927.28740-1-f.fainelli@gmail.com>
References: <20170118202927.28740-1-f.fainelli@gmail.com>
Message-ID: <20170118202927.28740-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the brcmstb entry to cover the Broadcom Brahma-B15 processor
read-ahead cache support code.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c36976d3bd1a..47ee4a93d554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2671,6 +2671,8 @@ S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
 F:	drivers/bus/brcmstb_gisb.c
+F:	arch/arm/mm/cache-b15-rac.c
+F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 N:	brcmstb
 
 BROADCOM BMIPS MIPS ARCHITECTURE
-- 
2.9.3
