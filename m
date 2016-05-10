From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 10 May 2016 20:59:58 +0200
Subject: [PATCH -trivial 3/3] spi: dw-pci: Spelling s/paltforms/platforms/g
In-Reply-To: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
References: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1462906798-27993-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-dw-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 332ccb0539a77710..ef7db75c92c13b34 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -67,7 +67,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dws->irq = pdev->irq;
 
 	/*
-	 * Specific handling for paltforms, like dma setup,
+	 * Specific handling for platforms, like dma setup,
 	 * clock rate, FIFO depth.
 	 */
 	if (desc) {
-- 
1.9.1
