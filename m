From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:12 +0900
Subject: [PATCH 06/19] ARM: shmobile: r7s72100: Remove r7s72100-genmai.dtb for
 ARCH_SHMOBILE_LEGACY
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <e8e0a1c70c53558ab9295a1a37aefab8fee15e1d.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Forgotten by commit ad8c3af8b75ff26c ("ARM: shmobile: r7s72100: Remove
legacy board support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 88282c8..59b6d3e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -376,7 +376,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
+dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
-- 
2.1.1
