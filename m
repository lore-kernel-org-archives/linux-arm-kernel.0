From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 28 Mar 2011 13:59:27 -0700
Subject: [PATCH] mach-types: add back vision_ep9307
Message-ID: <201103281359.29255.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add machine vision_ep9307 back to cut down mach-types.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

I'm not sure if this will happen automatically when the init code
for MACH_VISION_EP9307 gets merged (patch 6851/1).

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 7ca41f0..49b8ef5 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -271,6 +271,7 @@ pcm038			MACH_PCM038		PCM038			1551
 ts_x09			MACH_TS209		TS209			1565
 at91cap9adk		MACH_AT91CAP9ADK	AT91CAP9ADK		1566
 mx31moboard		MACH_MX31MOBOARD	MX31MOBOARD		1574
+vision_ep9307		MACH_VISION_EP9307	VISION_EP9307		1578
 terastation_pro2	MACH_TERASTATION_PRO2	TERASTATION_PRO2	1584
 linkstation_pro		MACH_LINKSTATION_PRO	LINKSTATION_PRO		1585
 e350			MACH_E350		E350			1596
