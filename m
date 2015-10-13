From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 13 Oct 2015 18:43:45 +0530
Subject: [PATCH v3 3/8] Documentation: dt-bindings: add exynos-srom binding
 information
In-Reply-To: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
References: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1444742030-31892-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds exynos-srom binding information for SROM Controller
driver on Exynos SoCs.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos-srom.txt          | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
new file mode 100644
index 0000000..33886d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -0,0 +1,12 @@
+SAMSUNG Exynos SoCs SROM Controller driver.
+
+Required properties:
+- compatible : Should contain "samsung,exynos-srom".
+
+- reg: offset and length of the register set
+
+Example:
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x10>;
+	};
-- 
2.4.5
