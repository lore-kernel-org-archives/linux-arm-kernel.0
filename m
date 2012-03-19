From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Mar 2012 17:47:43 +1100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20120319174743.aff001d4f84e82cf4042277a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mtd/nand/atmel_nand.c between commit 4331c79c6895 ("mtd: do not
use plain 0 as NULL") from the l2-mtd tree and commit d6a016616ba8
("atmel/nand: add DT support") from the arm-soc tree.

The latter superceded the former, so I used that.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/5f6c15e5/attachment.sig>
