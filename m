From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:25:57 +0100
Subject: [PATCH 02/23] mtd: inftl: kill unused oobinfo field
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/inftl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mtd/inftl.h b/include/linux/mtd/inftl.h
index 02cd5f9..8255118 100644
--- a/include/linux/mtd/inftl.h
+++ b/include/linux/mtd/inftl.h
@@ -44,7 +44,6 @@ struct INFTLrecord {
 	unsigned int nb_blocks;		/* number of physical blocks */
 	unsigned int nb_boot_blocks;	/* number of blocks used by the bios */
 	struct erase_info instr;
-	struct nand_ecclayout oobinfo;
 };
 
 int INFTL_mount(struct INFTLrecord *s);
-- 
2.1.4
