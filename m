From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:50:57 +1000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20120925165057.3a48eb9c4e3e4d70818e2791@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
drivers/mtd/nand/bcm_umi_nand.c and drivers/mtd/nand/nand_bcm_umi.h
between commit 07f4c69caf01 ("mtd: remove bcmring NAND driver") from the
l2-mtd tree and commit 878040ef831a ("ARM: bcmring: use proper MMIO
accessors") from the arm-soc tree.

I just removed the files and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/1e121e37/attachment-0001.sig>
