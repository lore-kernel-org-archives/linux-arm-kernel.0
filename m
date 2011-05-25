From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 17:09:30 +0530
Subject: [PATCH 2/2] dmaengine: add TODO items for future work on dma drivers
In-Reply-To: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
References: <1306323570-11133-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1306323570-11133-3-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/TODO |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/TODO

diff --git a/drivers/dma/TODO b/drivers/dma/TODO
new file mode 100644
index 0000000..b67d184
--- /dev/null
+++ b/drivers/dma/TODO
@@ -0,0 +1,12 @@
+TODO for slave dma
+
+1. Move remaining drivers to use new slave interface
+2. Remove old slave pointer machansim
+3. Make issue_pending to start the transaction in below drivers
+	- mpc512x_dma
+	- imx-dma
+	- imx-sdma
+	- mxs-dma.c
+	- dw_dmac
+	- intel_mid_dma
+	- ste_dma40
-- 
1.7.0.4
