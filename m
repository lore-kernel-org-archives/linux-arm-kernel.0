From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 8 Oct 2015 17:43:10 +0800
Subject: [PATCH v8 2/6] pci: add Altera PCI vendor ID
In-Reply-To: <1444297394-3122-1-git-send-email-lftan@altera.com>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
Message-ID: <1444297394-3122-3-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..08e4462 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1550,6 +1550,8 @@
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
 
+#define PCI_VENDOR_ID_ALTERA		0x1172
+
 #define PCI_VENDOR_ID_SBE		0x1176
 #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
 #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
-- 
1.8.2.1
