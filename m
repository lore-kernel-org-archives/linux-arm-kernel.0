From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:05 +0200
Subject: [PATCH 043/102] arm64: dts: renesas: r8a7795: add HDMI sound support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <5a0d8a6f504b04b26ae52449941c45263dd3a478.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 32870cbaf94d..b1c52dae4d49 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2335,6 +2335,10 @@
 				port at 1 {
 					reg = <1>;
 				};
+				port at 2 {
+					/* HDMI sound */
+					reg = <2>;
+				};
 			};
 		};
 
@@ -2360,6 +2364,10 @@
 				port at 1 {
 					reg = <1>;
 				};
+				port at 2 {
+					/* HDMI sound */
+					reg = <2>;
+				};
 			};
 		};
 
-- 
2.11.0
