From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 23 Jun 2017 14:55:44 +0200
Subject: [PATCH 2/8] spi: stm32: fix compatible to fit with new bindings
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498222550-19092-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates of_device_id compatible string to fit with new
bindings.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 82a6616f..ca38c24 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1038,7 +1038,7 @@ static int stm32_spi_config(struct stm32_spi *spi)
 }
 
 static const struct of_device_id stm32_spi_of_match[] = {
-	{ .compatible = "st,stm32-spi", },
+	{ .compatible = "st,stm32h7-spi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
-- 
1.9.1
