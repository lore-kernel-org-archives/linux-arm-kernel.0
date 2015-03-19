From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Mar 2015 18:09:05 -0700
Subject: [PATCH] MAINTAINERS: add brcmstb regex
Message-ID: <1426727345-5838-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This could probably consolidate a few file listings. And it satisfies
the spirit of the highly annoying [1] checkpatch warning for every new
file, though it sadly won't quash it.

[1] https://lkml.org/lkml/2014/12/17/24

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e1abe8cc684..52a1cf7cd18a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2179,6 +2179,7 @@ S:	Maintained
 F:	arch/arm/mach-bcm/*brcmstb*
 F:	arch/arm/boot/dts/bcm7*.dts*
 F:	drivers/bus/brcmstb_gisb.c
+N:	brcmstb
 
 BROADCOM BMIPS MIPS ARCHITECTURE
 M:	Kevin Cernekee <cernekee@gmail.com>
-- 
1.9.1
