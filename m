From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 20 Jun 2018 15:54:02 +0300
Subject: [PATCH 1/5] dt-bindings: tegra186-gpio: Add information for Tegra194
Message-ID: <20180620125406.11906-1-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra194 GPIO controller is similar to the one in Tegra186.
Add relevant information to the device tree binding documentation.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
index c82a2e221bc1..adff16c71d21 100644
--- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
@@ -68,6 +68,8 @@ Required properties:
     One of:
     - "nvidia,tegra186-gpio".
     - "nvidia,tegra186-gpio-aon".
+    - "nvidia,tegra194-gpio".
+    - "nvidia,tegra194-gpio-aon".
 - reg-names
     Array of strings.
     Contains a list of names for the register spaces described by the reg
@@ -91,6 +93,8 @@ Required properties:
     depending on compatible value:
     - "nvidia,tegra186-gpio": 6 entries.
     - "nvidia,tegra186-gpio-aon": 1 entry.
+    - "nvidia,tegra194-gpio": 6 entries.
+    - "nvidia,tegra194-gpio-aon": 1 entry.
 - gpio-controller
     Boolean.
     Marks the device node as a GPIO controller/provider.
-- 
2.16.1
