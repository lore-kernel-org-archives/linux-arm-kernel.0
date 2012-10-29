From: holzmayr@rsi-elektrotechnik.de (Josef Holzmayr)
Date: Mon, 29 Oct 2012 19:30:22 +0100
Subject: [PATCH] [PATCH] remove pcm049 from Makefile
Message-ID: <1351535422-4644-1-git-send-email-holzmayr@rsi-elektrotechnik.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-omap2/Makefile |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fe40d9e..d1155be 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,8 +236,6 @@ obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o
 
-obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o
-
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 
 obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
-- 
1.7.9.5


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch?ftsf?hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548
