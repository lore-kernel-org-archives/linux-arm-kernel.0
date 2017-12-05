From: amery@hanoverdisplays.com (Alejandro Mery)
Date: Tue, 5 Dec 2017 12:34:58 +0000
Subject: [PATCH v2 3/3] ARM: davinci: fix mmc entries in DM365's eDMA slaves
 table
In-Reply-To: <20171205123458.97837-1-amery@hanoverdisplays.com>
References: <2298378f-37d0-0c04-dfe3-4503c58e5456@ti.com>,
 <20171204133359.45625-1-amery@hanoverdisplays.com>
 <20171205123458.97837-1-amery@hanoverdisplays.com>
Message-ID: <20171205123458.97837-4-amery@hanoverdisplays.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
---
 arch/arm/mach-davinci/dm365.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 103316f01a22..5ace9380626a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -868,10 +868,10 @@ static const struct dma_slave_map dm365_edma_map[] = {
 	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 17) },
 	{ "spi_davinci.3", "tx", EDMA_FILTER_PARAM(0, 18) },
 	{ "spi_davinci.3", "rx", EDMA_FILTER_PARAM(0, 19) },
-	{ "dm6441-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
-	{ "dm6441-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
-	{ "dm6441-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
-	{ "dm6441-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
+	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 26) },
+	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 27) },
+	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(0, 30) },
+	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(0, 31) },
 };
 
 static struct edma_soc_info dm365_edma_pdata = {
-- 
2.15.0
