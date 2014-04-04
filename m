From: treding@nvidia.com (Thierry Reding)
Date: Fri, 4 Apr 2014 16:49:28 +0200
Subject: [RFC 4/5] PCI: tegra: Remove deprecated power supply properties
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
Message-ID: <1396622969-17837-5-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These power supply properties are no longer needed since the binding now
contains the full set properties to accurately describe the power supply
inputs of the Tegra PCIe block.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index 66e8aca4aef0..5207d4cd1fa2 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -84,11 +84,6 @@ Power supplies for Tegra30:
     - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
     - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
 
-Deprecated supplies:
-- pex-clk-supply: Supply voltage for internal reference clock
-- vdd-supply: Power supply for controller (1.05V)
-- avdd-supply: Power supply for controller (1.05V) (not required for Tegra20)
-
 Root ports are defined as subnodes of the PCIe controller node.
 
 Required properties:
-- 
1.9.1
