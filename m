From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Jan 2017 10:14:23 +0100
Subject: [PATCH 1/9] arm64: dts: h3ulcb: follow sound CTU/MIX supports
In-Reply-To: <cover.1485508214.git.horms+renesas@verge.net.au>
References: <cover.1485508214.git.horms+renesas@verge.net.au>
Message-ID: <b1980ff0c335eedbba10ea99a2a9feebb79642f8.1485508214.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 5bcd74e8a30d9259 ("arm64: dts: r8a7795: add sound MIX support")
commit 5be5ee41d011f26b ("arm64: dts: r8a7795: add sound CTU support")
added MIX/CTU support, and it updated clocks on SoC level.
Thus, h3ulcb should be updated

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index 6ffb0517421a..553d8968c0cf 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -277,6 +277,8 @@
 		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
+		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
 		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 		 <&audio_clk_a>, <&cs2000>,
 		 <&audio_clk_c>,
-- 
2.7.0.rc3.207.g0ac5344
