From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 22:08:23 +0200
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
Message-ID: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bcm2836 (Raspberry Pi 2) and bcm2837 (Raspberry Pi 3).

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26edd832c64e..d69449735876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2612,7 +2612,7 @@ N:	bcm216*
 N:	kona
 F:	arch/arm/mach-bcm/
 
-BROADCOM BCM2835 ARM ARCHITECTURE
+BROADCOM BCM2835/BCM2836/BCM2837 ARM ARCHITECTURE
 M:	Stephen Warren <swarren@wwwdotorg.org>
 M:	Lee Jones <lee@kernel.org>
 M:	Eric Anholt <eric@anholt.net>
@@ -2620,7 +2620,7 @@ L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
-N:	bcm2835
+N:	bcm283[5-7x]
 F:	drivers/staging/vc04_services
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
-- 
2.11.0
