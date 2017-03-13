From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 13 Mar 2017 19:52:52 +0530
Subject: [PATCH v4 16/23] PCI: Add device IDs for DRA74x and DRA72x
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
Message-ID: <20170313142259.25397-17-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device IDs for DRA74x and DRA72x devices. These devices have
configurable PCI endpoint.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a4f77feecbb0..5f6b71d15393 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -862,6 +862,8 @@
 #define PCI_DEVICE_ID_TI_X620		0xac8d
 #define PCI_DEVICE_ID_TI_X420		0xac8e
 #define PCI_DEVICE_ID_TI_XX20_FM	0xac8f
+#define PCI_DEVICE_ID_TI_DRA74x		0xb500
+#define PCI_DEVICE_ID_TI_DRA72x		0xb501
 
 #define PCI_VENDOR_ID_SONY		0x104d
 
-- 
2.11.0
