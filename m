From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:24 +0100
Subject: [PATCH 05/52] ARM: dts: iwg20m: Enable cmt0
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <cbeb319b9f220982acc2f533ffee5042a6763c39.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch enables cmt0 support from within the iwg20m SoM dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 75a8ca571846..1d3e9503c5bd 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -34,6 +34,10 @@
 	};
 };
 
+&cmt0 {
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
-- 
2.11.0
