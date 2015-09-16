From: rjui@broadcom.com (Ray Jui)
Date: Tue, 15 Sep 2015 17:39:15 -0700
Subject: [PATCH 1/8] PCI: iproc: Fix code comment
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442363962-29805-2-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix code comment in pcie-iproc.h so it matches the code

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index c9e4c10..4880b09 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -20,11 +20,11 @@
  * iProc PCIe device
  * @dev: pointer to device data structure
  * @base: PCIe host controller I/O register base
- * @resources: linked list of all PCI resources
  * @sysdata: Per PCI controller data (ARM-specific)
  * @root_bus: pointer to root bus
  * @phy: optional PHY device that controls the Serdes
  * @irqs: interrupt IDs
+ * @map_irq: function callback to map interrupts
  */
 struct iproc_pcie {
 	struct device *dev;
-- 
1.9.1
