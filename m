From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:36:57 +0900
Subject: [PATCH 10/16] ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for
 legacy builds
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
Message-ID: <6a902a2ea1ffe432ce46bb562b9dcae8f396b3b4.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The legacy board code for Armadillo-800 EVA has been removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b1d0a12a94ef..14fc8f1fe2d8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -501,7 +501,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb
-- 
2.1.4
