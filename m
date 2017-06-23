From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:27 -0700
Subject: [PATCH v2 7/7] MAINTAINERS: Update brcmstb entries to cover B15 code
In-Reply-To: <20170623175227.19743-1-f.fainelli@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
Message-ID: <20170623175227.19743-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the brcmstb entry to cover the Broadcom Brahma-B15 processor
read-ahead cache support code.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b5ab6a8a5c..1e2035ef7c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2748,6 +2748,8 @@ S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
 F:	drivers/bus/brcmstb_gisb.c
+F:	arch/arm/mm/cache-b15-rac.c
+F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 N:	brcmstb
 
 BROADCOM BMIPS MIPS ARCHITECTURE
-- 
2.9.3
