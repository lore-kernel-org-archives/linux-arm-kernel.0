From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 29 Apr 2015 14:08:32 +0530
Subject: [PATCH 5/5] Documentation: dt-bindings: add exynos-srom binding
 information
In-Reply-To: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1430296712-10287-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds exynos-srom binding information for SROM Controller
driver on Exynos SoCs.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/arm/samsung/exynos-srom.txt          | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
new file mode 100644
index 0000000..482d1cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
@@ -0,0 +1,12 @@
+SAMSUNG Exynos SoCs SROM Controller driver.
+
+Required properties:
+- compatible : Should at least contain "samsung,exynos-srom".
+
+- reg: offset and length of the register set
+
+Example:
+	sromc at 12570000 {
+		compatible = "samsung,exynos-srom";
+		reg = <0x12570000 0x100>;
+	};
-- 
2.2.0
