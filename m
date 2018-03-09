From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 16:40:16 +0100
Subject: [PATCH v2] dt-bindings: exynos: Document #sound-dai-cells property
 of the HDMI node
References: <CGME20180309154029epcas1p280472548d1aa86daafceb405b10f1589@epcas1p2.samsung.com>
Message-ID: <20180309154016.15562-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #sound-dai-cells DT property is required to describe link between
the HDMI IP block and the SoC's audio subsystem.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - the property has been moved to "Required properties" paragraph,
   I didn't add Rob's Reviewed-by due to this change
---
 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
index 8715ff06c457..ecb2899f4451 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
@@ -16,6 +16,7 @@ Required properties:
 - ddc: phandle to the hdmi ddc node
 - phy: phandle to the hdmi phy node
 - samsung,syscon-phandle: phandle for system controller node for PMU.
+- #sound-dai-cells: should be 0.

 Required properties for Exynos 4210, 4212, 5420 and 5433:
 - clocks: list of clock IDs from SoC clock driver.
--
2.14.2
