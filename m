From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:23 +0900
Subject: [PATCH 092/130] ARM: shmobile: r8a7740: Remove FSI function GPIOs
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-93-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 08b7da0..001302f 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -107,20 +107,6 @@ enum {
 	GPIO_FN_DBGMD10,	GPIO_FN_DBGMD11,	GPIO_FN_DBGMD20,
 	GPIO_FN_DBGMD21,
 
-	/* FSI-A */
-	GPIO_FN_FSIAISLD_PORT0,		/* FSIAISLD Port 0/5 */
-	GPIO_FN_FSIAISLD_PORT5,
-	GPIO_FN_FSIASPDIF_PORT9,	/* FSIASPDIF Port 9/18 */
-	GPIO_FN_FSIASPDIF_PORT18,
-	GPIO_FN_FSIAOSLD1,	GPIO_FN_FSIAOSLD2,
-	GPIO_FN_FSIAOLR,	GPIO_FN_FSIAOBT,
-	GPIO_FN_FSIAOSLD,	GPIO_FN_FSIAOMC,
-	GPIO_FN_FSIACK,		GPIO_FN_FSIAILR,
-	GPIO_FN_FSIAIBT,
-
-	/* FSI-B */
-	GPIO_FN_FSIBCK,
-
 	/* FMSI */
 	GPIO_FN_FMSISLD_PORT1, /* FMSISLD Port 1/6 */
 	GPIO_FN_FMSISLD_PORT6,
-- 
1.8.2.1
