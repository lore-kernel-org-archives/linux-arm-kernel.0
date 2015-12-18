From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:09 +0900
Subject: [PATCH 01/10] arm64: renesas: salvator-x: set ak4613 In/Out pin as
 single-end
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <40fbe14b54bac16d5ec2fcf077b8aa54fb9de6b2.1450401186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index c5f709e7c0ba..beeacfaf18d0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -141,6 +141,15 @@
 		#sound-dai-cells = <0>;
 		reg = <0x10>;
 		clocks = <&rcar_sound 3>;
+
+		asahi-kasei,in1-single-end;
+		asahi-kasei,in2-single-end;
+		asahi-kasei,out1-single-end;
+		asahi-kasei,out2-single-end;
+		asahi-kasei,out3-single-end;
+		asahi-kasei,out4-single-end;
+		asahi-kasei,out5-single-end;
+		asahi-kasei,out6-single-end;
 	};
 };
 
-- 
2.1.4
