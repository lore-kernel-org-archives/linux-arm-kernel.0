From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 15 Mar 2017 13:31:54 +0000
Subject: [PATCH 4/5] dt-bindings: tegra: Update compatible strings for Tegra
 flowctrl
In-Reply-To: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1489584715-23138-5-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the compatible strings for Tegra Flow Control driver to match
the device-tree source files for Tegra.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
index ccf0adddc820..d92bf782985f 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
@@ -1,7 +1,13 @@
 NVIDIA Tegra Flow Controller
 
 Required properties:
-- compatible: Should be "nvidia,tegra<chip>-flowctrl"
+- compatible: Should contain one of the following:
+	For Tegra20 must contain "nvidia,tegra20-flowctrl".
+	For Tegra30 must contain "nvidia,tegra30-flowctrl".
+	For Tegra114 must contain "nvidia,tegra114-flowctrl"
+	For Tegra124 must contain "nvidia,tegra124-flowctrl"
+	For Tegra132 must contain "nvidia,tegra124-flowctrl"
+	For Tegra210 must contain "nvidia,tegra210-flowctrl"
 - reg: Should contain one register range (address and length)
 
 Example:
-- 
2.7.4
