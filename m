From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Mar 2018 18:11:11 +0100
Subject: [PATCH] dt-bindings: exynos: Document #sound-dai-cells property of
 the HDMI node
References: <CGME20180307171131epcas1p4687ef394d1a0a6d0eb2de2691c977c3f@epcas1p4.samsung.com>
Message-ID: <20180307171111.14551-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #sound-dai-cells DT property is required to describe link between
the HDMI IP block and the SoC's audio subsystem.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
index 8715ff06c457..6b2a526ec586 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
@@ -50,6 +50,9 @@ Required properties for Exynos 5433:
 - clock-names: aliases for above clock specfiers.
 - samsung,sysreg: handle to syscon used to control the system registers.
 
+Optional properties for Exynos 4210, 4212, 5420 and 5433:
+ - #sound-dai-cells: should be 0.
+
 Example:
 
 	hdmi {
-- 
2.14.2
