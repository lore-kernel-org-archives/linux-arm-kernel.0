From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 28 Jun 2017 22:30:30 +0200
Subject: [PATCH v4 3/9] mfd: tmio.h: support partition parser types
In-Reply-To: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Message-ID: <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 include/linux/mfd/tmio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a1520d8..23bb069 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -139,6 +139,7 @@ struct tmio_nand_data {
 	struct nand_bbt_descr	*badblock_pattern;
 	struct mtd_partition	*partition;
 	unsigned int		num_partitions;
+	const char *const	*types;	/* names of parsers to use if any */
 };
 
 #define FBIO_TMIO_ACC_WRITE	0x7C639300
-- 
2.7.4
