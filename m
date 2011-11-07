From: michael@walle.cc (Michael Walle)
Date: Mon,  7 Nov 2011 21:54:11 +0100
Subject: [PATCH] ARM: Add lsxhl machine type to mach-types
Message-ID: <1320699251-26115-1-git-send-email-michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Re-)add Buffalo Linkstation Pro LS-XHL machine type.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 5bdeef9..d50917e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -458,6 +458,7 @@ mityomapl138		MACH_MITYOMAPL138	MITYOMAPL138		2650
 guruplug		MACH_GURUPLUG		GURUPLUG		2659
 spear310		MACH_SPEAR310		SPEAR310		2660
 spear320		MACH_SPEAR320		SPEAR320		2661
+lsxhl			MACH_LSXHL		LSXHL			2663
 aquila			MACH_AQUILA		AQUILA			2676
 sheeva_esata		MACH_ESATA_SHEEVAPLUG	ESATA_SHEEVAPLUG	2678
 msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
-- 
1.7.2.5
