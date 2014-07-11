From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 08:58:57 +0200
Subject: [PATCH 1/2] PCI: mvebu: Fix license string
Message-ID: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
"GPLv2".

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ce23e0f076b6..a8c6f1a92e0f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1094,4 +1094,4 @@ module_platform_driver(mvebu_pcie_driver);
 
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.0.1
