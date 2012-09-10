From: gerg@snapgear.com (gerg at snapgear.com)
Date: Mon, 10 Sep 2012 13:30:15 +1000
Subject: [PATCH] ARM: add back in KS8695 based SnapGear board entries
Message-ID: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Board support code for the SnapGear boards based on the Micrel KS8695 SoC
will soon appear in mainline kernel. The board IDs had been removed from
the mach-types file, so add them back in.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/tools/mach-types |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 2997e56..69a3e81 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -96,6 +96,7 @@ lpd7a400		MACH_LPD7A400		LPD7A400		389
 lpd7a404		MACH_LPD7A404		LPD7A404		390
 csb337			MACH_CSB337		CSB337			399
 mainstone		MACH_MAINSTONE		MAINSTONE		406
+lite300			MACH_LITE300		LITE300			408
 xcep			MACH_XCEP		XCEP			413
 arcom_vulcan		MACH_ARCOM_VULCAN	ARCOM_VULCAN		414
 nomadik			MACH_NOMADIK		NOMADIK			420
@@ -162,6 +163,7 @@ pnx4008			MACH_PNX4008		PNX4008			782
 cpuat91			MACH_CPUAT91		CPUAT91			787
 iq81340sc		MACH_IQ81340SC		IQ81340SC		799
 iq81340mc		MACH_IQ81340MC		IQ81340MC		801
+se4200			MACH_SE4200		SE4200			809
 micro9			MACH_MICRO9		MICRO9			811
 micro9l			MACH_MICRO9L		MICRO9L			812
 omap_palmte		MACH_OMAP_PALMTE	OMAP_PALMTE		817
@@ -270,6 +272,7 @@ dns323			MACH_DNS323		DNS323			1542
 omap3_beagle		MACH_OMAP3_BEAGLE	OMAP3_BEAGLE		1546
 nokia_n810		MACH_NOKIA_N810		NOKIA_N810		1548
 pcm038			MACH_PCM038		PCM038			1551
+sg310			MACH_SG310		SG310			1564
 ts209			MACH_TS209		TS209			1565
 at91cap9adk		MACH_AT91CAP9ADK	AT91CAP9ADK		1566
 mx31moboard		MACH_MX31MOBOARD	MX31MOBOARD		1574
-- 
1.7.0.4
