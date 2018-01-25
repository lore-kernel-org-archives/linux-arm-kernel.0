From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:02:47 +0000
Subject: [RFC 13/37] ARM: dts: r8a7745: Use fallback rst compatible string
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the generic fallback compatible string for the rst node.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 32e8784..9009056 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -317,7 +317,8 @@
 		};
 
 		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7745-rst";
+			compatible = "renesas,r8a7745-rst",
+				     "renesas,rcar-gen2-rst";
 			reg = <0 0xe6160000 0 0x100>;
 		};
 
-- 
2.7.4
