From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  3 Feb 2017 19:12:11 +0100
Subject: [PATCH net-next 3/8] pci: add Annapurna Labs PCI id
In-Reply-To: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
Message-ID: <20170203181216.30214-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the Annapurna Labs vendor id.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73dda0edcb97..8a11e2d8f35f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -148,6 +148,8 @@
 #define PCI_VENDOR_ID_DYNALINK		0x0675
 #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
 
+#define PCI_VENDOR_ID_ANNAPURNA_LABS	0x1c36
+
 #define PCI_VENDOR_ID_BERKOM			0x0871
 #define PCI_DEVICE_ID_BERKOM_A1T		0xffa1
 #define PCI_DEVICE_ID_BERKOM_T_CONCEPT		0xffa2
-- 
2.11.0
