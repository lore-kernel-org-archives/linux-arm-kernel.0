From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 11 Jan 2018 20:59:39 +0000
Subject: [PATCH] ARM: dts: iwg22m: Enable cmt0
In-Reply-To: <1515704379-29154-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1515704379-29154-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1515704379-29154-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables cmt0 support from within the iwg22m SoM dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index ed9a8cf..8d0a392b 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -29,6 +29,10 @@
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
2.7.4
