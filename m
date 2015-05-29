From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:14 +0900
Subject: [PATCH 06/10] ARM: shmobile: r8a7790: add MMCIF max-frequency
In-Reply-To: <cover.1432860632.git.horms+renesas@verge.net.au>
References: <cover.1432860632.git.horms+renesas@verge.net.au>
Message-ID: <96370057bd47e8785312e151e3b32ad712693910.1432860632.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 62a9086b133d..70248df02342 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -490,6 +490,7 @@
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
+		max-frequency = <97500000>;
 	};
 
 	mmcif1: mmc at ee220000 {
@@ -501,6 +502,7 @@
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
+		max-frequency = <97500000>;
 	};
 
 	pfc: pfc at e6060000 {
-- 
2.1.4
