From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 13:01:24 +0200
Subject: [PATCH 5/5] MAINTAINERS: Add maintainers entry for Rockchip SoCs
In-Reply-To: <201310151258.53435.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
Message-ID: <201310151301.25153.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I plan to stay with the Rockchip SoCs for the foreseable future
and hope to expand its support along the way.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..efa92cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1142,6 +1142,13 @@ F:	drivers/net/ethernet/i825xx/ether1*
 F:	drivers/net/ethernet/seeq/ether3*
 F:	drivers/scsi/arm/
 
+ARM/Rockchip SoC support
+M:	Heiko Stuebner <heiko@sntech.de>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-rockchip/
+F:	drivers/*/*rockchip*
+
 ARM/SHARK MACHINE SUPPORT
 M:	Alexander Schulz <alex@shark-linux.de>
 W:	http://www.shark-linux.de/shark.html
-- 
1.7.10.4
