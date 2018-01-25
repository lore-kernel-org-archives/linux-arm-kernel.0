From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:02:52 +0000
Subject: [RFC 18/37] arm64: dts: renesas: r8a7796: Use fallback rst compatible
 string
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the generic fallback compatible string for the rst node.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index f8e9313..7b347d8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -510,7 +510,8 @@
 		};
 
 		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7796-rst";
+			compatible = "renesas,r8a7796-rst",
+				     "renesas,rcar-gen3-rst";
 			reg = <0 0xe6160000 0 0x0200>;
 		};
 
-- 
2.7.4
