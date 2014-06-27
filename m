From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 14:07:26 +0200
Subject: [PATCH v2 1/3] of: Add NVIDIA Tegra flow controller bindings
Message-ID: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add device tree bindings for the flow controller found on NVIDIA Tegra
SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra114-flowctrl.txt          | 12 ++++++++++++
 .../bindings/arm/tegra/nvidia,tegra124-flowctrl.txt          | 12 ++++++++++++
 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt           | 12 ++++++++++++
 .../bindings/arm/tegra/nvidia,tegra30-flowctrl.txt           | 12 ++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-flowctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra124-flowctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-flowctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-flowctrl.txt
new file mode 100644
index 000000000000..72599fdb09a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra114-flowctrl.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra114 Flow Controller
+
+Required properties:
+- compatible: "nvidia,tegra114-flowctrl"
+- reg: Should contain one register range (address and length)
+
+Example:
+
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra114-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra124-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra124-flowctrl.txt
new file mode 100644
index 000000000000..3af5fe2019f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra124-flowctrl.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra124 Flow Controller
+
+Required properties:
+- compatible: "nvidia,tegra124-flowctrl"
+- reg: Should contain one register range (address and length)
+
+Example:
+
+	flow-controller at 0,60007000 {
+		compatible = "nvidia,tegra124-flowctrl";
+		reg = <0x0 0x60007000 0x0 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
new file mode 100644
index 000000000000..b077ca8a22c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra20 Flow Controller
+
+Required properties:
+- compatible: "nvidia,tegra20-flowctrl"
+- reg: Should contain one register range (address and length)
+
+Example:
+
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra20-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-flowctrl.txt
new file mode 100644
index 000000000000..72c90dd59110
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-flowctrl.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra30 Flow Controller
+
+Required properties:
+- compatible: "nvidia,tegra30-flowctrl"
+- reg: Should contain one register range (address and length)
+
+Example:
+
+	flow-controller at 60007000 {
+		compatible = "nvidia,tegra30-flowctrl";
+		reg = <0x60007000 0x1000>;
+	};
-- 
2.0.0
