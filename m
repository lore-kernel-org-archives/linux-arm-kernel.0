From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:36:53 +0900
Subject: [PATCH 06/16] ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
Message-ID: <d99f70b9533dc355e0facbaee8a42dcd821a5e73.1436509680.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The legacy board code for KZM-A9-GT has been removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a244f6..b1d0a12a94ef 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -504,8 +504,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
-	r8a7779-marzen.dtb \
-	sh73a0-kzm9g.dtb
+	r8a7779-marzen.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-- 
2.1.4
