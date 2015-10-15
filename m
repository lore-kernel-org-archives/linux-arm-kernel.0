From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 15 Oct 2015 12:17:47 +0530
Subject: [PATCH v3 07/12] doc: DTS: Update DWC3 binding to provide reference
 to generic bindings
In-Reply-To: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1444891672-32117-8-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Synopsys DWC3 controller driver inherits the generic bindings
defined in 'usb/generic.txt', this patch tries to capture the same in
the DWC3 binging documentation to avoid any confusion in usage of properties
like 'dr_mode' for certain SoCs like FSL LS2080A.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9ff48e0..fb2ad0a 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -1,6 +1,7 @@
 synopsys DWC3 CORE
 
-DWC3- USB3 CONTROLLER
+DWC3- USB3 CONTROLLER. Complies to the generic USB binding properties
+      as described in 'usb/generic.txt'
 
 Required properties:
  - compatible: must be "snps,dwc3"
-- 
1.7.9.5
