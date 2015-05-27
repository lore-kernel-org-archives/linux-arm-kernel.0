From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Tue, 26 May 2015 19:20:14 -0700
Subject: [PATCH net-next v6 1/2] pci: Add Cavium PCI vendor id
In-Reply-To: <1432693228-5554-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1432693228-5554-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1432693228-5554-2-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This vendor id will be used by network (vNIC), USB (xHCI),
SATA (AHCI), GPIO, I2C, MMC and maybe other drivers
for ThunderX SoC.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1fa99a3..80bd333 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2324,6 +2324,8 @@
 #define PCI_DEVICE_ID_ALTIMA_AC9100	0x03ea
 #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
 
+#define PCI_VENDOR_ID_CAVIUM		0x177d
+
 #define PCI_VENDOR_ID_BELKIN		0x1799
 #define PCI_DEVICE_ID_BELKIN_F5D7010V7	0x701f
 
-- 
2.4.1
