From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Apr 2018 19:34:23 +0800
Subject: [PATCH 6/7] arm64: dts: allwinner: Sort dtb entries in Makefile
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Message-ID: <20180424113424.13196-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dtb entries for NanoPi boards in the device tree makefile somehow
ended up after the Orange Pi boards.

Move them so the list is properly sorted.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 8bebe7da5ed9..6ec126e86183 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -6,10 +6,10 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
-- 
2.17.0
