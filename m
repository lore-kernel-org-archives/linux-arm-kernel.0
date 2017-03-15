From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 15 Mar 2017 20:11:02 +0000
Subject: [PATCH v6 3/3] MAINTAINERS: Broadcom Vulcan is now Cavium ThunderX2
In-Reply-To: <1489608662-4434-1-git-send-email-jnair@caviumnetworks.com>
References: <1489495634-2920-1-git-send-email-jnair@caviumnetworks.com>
 <1489608662-4434-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1489608662-4434-4-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the dts files are moved to the new location, we can remove
the Broadcom Vulcan entry in the MAINTAINERS.

Also fix up the Cavium ThunderX2 entry with the correct pattern for
the new names.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..81a1f2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2838,13 +2838,6 @@ L:	netdev at vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/bcmsysport.*
 
-BROADCOM VULCAN ARM64 SOC
-M:	Jayachandran C. <c.jayachandran@gmail.com>
-M:	bcm-kernel-feedback-list at broadcom.com
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm64/boot/dts/broadcom/vulcan*
-
 BROADCOM NETXTREME-E ROCE DRIVER
 M:	Selvin Xavier <selvin.xavier@broadcom.com>
 M:	Devesh Sharma <devesh.sharma@broadcom.com>
@@ -3030,7 +3023,7 @@ CAVIUM THUNDERX2 ARM64 SOC
 M:	Jayachandran C <jnair@caviumnetworks.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm64/boot/dts/cavium/thunder-99xx*
+F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
 F:	Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 
 CAVIUM I2C DRIVER
-- 
2.7.4
