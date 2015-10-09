From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri,  9 Oct 2015 14:45:20 +0100
Subject: [PATCH 1/4] pci: Add PLDA's XpressRICH3 PCIe host bridge PCI ID
In-Reply-To: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
References: <1444398323-17354-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1444398323-17354-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Murray <Andrew.Murray@arm.com>

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..1542b2b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1319,6 +1319,9 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
 
+#define PCI_VENDOR_ID_PLDA		0x1556
+#define PCI_DEVICE_ID_XR3PCI		0x1100
+
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
 #define PCI_DEVICE_ID_IMS_TT3D		0x9135
-- 
2.6.0
