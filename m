From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  4 Apr 2016 14:43:38 +0200
Subject: [PATCH] ARM: sa1100: remove references to the defunct handhelds.org
Message-ID: <1459773818-27373-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The website handhelds.org has been down for a long time and is
likely never coming back online.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this patch directly to whatever
branch is appropriate.
---
 arch/arm/mach-sa1100/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index c6f6ed1cbed0..36e3c79f4973 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -61,10 +61,7 @@ config SA1100_H3100
 	select MFD_IPAQ_MICRO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
-	  H3100 handheld computer.  Information about this machine and the
-	  Linux port to this machine can be found at:
-
-	  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3100>
+	  H3100 handheld computer.
 
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
@@ -73,10 +70,7 @@ config SA1100_H3600
 	select MFD_IPAQ_MICRO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
-	  H3600 handheld computer.  Information about this machine and the
-	  Linux port to this machine can be found at:
-
-	  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3600>
+	  H3600 and H3700 handheld computers.
 
 config SA1100_BADGE4
 	bool "HP Labs BadgePAD 4"
-- 
2.4.3
