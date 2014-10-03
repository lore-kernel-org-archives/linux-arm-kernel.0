From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  3 Oct 2014 16:55:52 +0200
Subject: [PATCH] ARM: shmobile: r7s72100: Remove r7s72100-genmai.dtb for
 ARCH_SHMOBILE_LEGACY
Message-ID: <1412348152-15326-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgotten by commit ad8c3af8b75ff26c ("ARM: shmobile: r7s72100: Remove
legacy board support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a9125b8d394e5c4a..dc619a48d2c5bb70 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -357,7 +357,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7s72100-genmai.dtb \
+dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
-- 
1.9.1
