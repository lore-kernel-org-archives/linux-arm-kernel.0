From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Mar 2017 13:42:56 +0100
Subject: [PATCH V3 4/6] dt-bindings: tegra: Update compatible strings for
 Tegra flowctrl
In-Reply-To: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490704978-22906-5-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the compatible strings for Tegra Flow Control driver to match
the device-tree source files for Tegra.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
index ccf0adddc820..a855c1bffc0f 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
@@ -1,7 +1,13 @@
 NVIDIA Tegra Flow Controller
 
 Required properties:
-- compatible: Should be "nvidia,tegra<chip>-flowctrl"
+- compatible: Should contain one of the following:
+  - "nvidia,tegra20-flowctrl": for Tegra20
+  - "nvidia,tegra30-flowctrl": for Tegra30
+  - "nvidia,tegra114-flowctrl": for Tegra114
+  - "nvidia,tegra124-flowctrl": for Tegra124
+  - "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl": for Tegra132
+  - "nvidia,tegra210-flowctrl": for Tegra210
 - reg: Should contain one register range (address and length)
 
 Example:
-- 
2.7.4
