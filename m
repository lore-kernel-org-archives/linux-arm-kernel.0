From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu,  8 Nov 2012 06:37:09 +0100
Subject: [PATCH] [TRIVIAL] ARM: cns3xxx: drop unnessesary symbol selection
Message-ID: <1352353029-2725-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_CNS3XXX already selects MIGHT_HAVE_PCI, so boards don't have to

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/mach-cns3xxx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 29b13f2..9ebfcc4 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -3,7 +3,6 @@ menu "CNS3XXX platform type"
 
 config MACH_CNS3420VB
 	bool "Support for CNS3420 Validation Board"
-	select MIGHT_HAVE_PCI
 	help
 	  Include support for the Cavium Networks CNS3420 MPCore Platform
 	  Baseboard.
-- 
1.7.1
