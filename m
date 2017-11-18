From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Nov 2017 12:10:03 +0900
Subject: [PATCH] arm64: dts: sort vendor subdirectories in Makefile
 alphabetically
Message-ID: <1510974603-7463-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The list is almost sorted.  Move "lg" up to complete it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index d7c22d5..4aa50b9 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -12,6 +12,7 @@ subdir-y += cavium
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
+subdir-y += lg
 subdir-y += marvell
 subdir-y += mediatek
 subdir-y += nvidia
@@ -22,5 +23,4 @@ subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
 subdir-y += xilinx
-subdir-y += lg
 subdir-y += zte
-- 
2.7.4
