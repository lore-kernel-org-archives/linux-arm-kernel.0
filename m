From: colin.king@canonical.com (Colin King)
Date: Sun,  3 Apr 2016 11:56:16 +0100
Subject: [PATCH] PCI: xilinx-nwl: Fix spelling mistake "Initialization"
Message-ID: <1459680976-32222-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Minor fix, spelling mistake "Initalization" should be
"Initialization".

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 5139e64..3479d30 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -819,7 +819,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	err = nwl_pcie_bridge_init(pcie);
 	if (err) {
-		dev_err(pcie->dev, "HW Initalization failed\n");
+		dev_err(pcie->dev, "HW Initialization failed\n");
 		return err;
 	}
 
-- 
2.7.4
