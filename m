From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:21 +0200
Subject: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree compatibility
 list
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an entry for the TotalPhase Aardvark SPI Host Adapter,
which can operate as an SPI Slave.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a2a79a..8093885 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -698,6 +698,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
+	{ .compatible = "totalphase,aardvark" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
1.9.1
