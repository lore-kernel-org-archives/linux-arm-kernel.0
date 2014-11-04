From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:46 +0900
Subject: [PATCH 6/7] ARM: dts: koelsch: Stop building r8a7791-koelsch.dtb in
 legacy builds
In-Reply-To: <cover.1415059146.git.horms+renesas@verge.net.au>
References: <cover.1415059146.git.horms+renesas@verge.net.au>
Message-ID: <0456a4c14afb398ede4020eefa5dece45d86ed36.1415059146.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Koelsch is no longer supported in legacy builds.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59b6d3e..8df0598 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -384,7 +384,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
-	r8a7791-koelsch.dtb \
 	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb
-- 
2.1.1
