From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Thu, 27 Nov 2014 20:47:33 +0530
Subject: [PATCH v5 1/2] Documentation: devicetree: Add ECC information to
 synopsys ddr controller
Message-ID: <1d7215b92ad4406b8bf5c593a9a13167@BN1BFFO11FD020.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ECC information to synopsys ddr memory controller.

Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index f9c6454..a43d26d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,5 +1,9 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
+This controller has an optional ECC support in half-bus width (16-bit)
+configuration. The ECC controller corrects one bit error and detects
+two bit errors.
+
 Required properties:
  - compatible: Should be 'xlnx,zynq-ddrc-a05'
  - reg: Base address and size of the controllers memory area
-- 
1.7.4
