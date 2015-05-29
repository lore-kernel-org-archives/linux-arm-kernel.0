From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 May 2015 09:54:15 +0900
Subject: [PATCH 07/10] ARM: shmobile: r8a7791: add MMCIF max-frequency
In-Reply-To: <cover.1432860632.git.horms+renesas@verge.net.au>
References: <cover.1432860632.git.horms+renesas@verge.net.au>
Message-ID: <d957ab8dbd79ccd32f6f7c42651b956bb892858d.1432860632.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 7613abea13d7..bbef666596e5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -494,6 +494,7 @@
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
+		max-frequency = <97500000>;
 	};
 
 	sdhi0: sd at ee100000 {
-- 
2.1.4
