From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:38 +0900
Subject: [PATCH 15/21] ARM: shmobile: Remove Koelsch reference DTS
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <82f7c2065a363cd3c0c84d3c9b59ee47897c5ebb.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Now that the DTS file r8a7790-koelsch.dts can be used with
board-koelsch.c and board-koelsch-reference.c, proceed with removing
r8a7790-koelsch-reference.dts.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 909d910..5839077 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -225,7 +225,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a7779-marzen.dtb \
 	r8a7779-marzen-reference.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7791-koelsch-reference.dtb \
 	r8a7790-lager.dtb \
 	r8a7790-lager-reference.dtb \
 	sh73a0-kzm9g.dtb \
-- 
1.8.4
