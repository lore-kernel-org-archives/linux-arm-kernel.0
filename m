From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:25:58 +0100
Subject: [PATCH 03/23] mtd: nftl: kill unused oobinfo field
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/nftl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mtd/nftl.h b/include/linux/mtd/nftl.h
index b059629..044daa0 100644
--- a/include/linux/mtd/nftl.h
+++ b/include/linux/mtd/nftl.h
@@ -50,7 +50,6 @@ struct NFTLrecord {
         unsigned int nb_blocks;		/* number of physical blocks */
         unsigned int nb_boot_blocks;	/* number of blocks used by the bios */
         struct erase_info instr;
-	struct nand_ecclayout oobinfo;
 };
 
 int NFTL_mount(struct NFTLrecord *s);
-- 
2.1.4
