From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 1 May 2012 15:34:41 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20120501153441.5e101139fb096ef262ff1d2b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mfd/ab5500-core.c between commit 9ea969f0d79d ("mfd: Mark const
init data with __initconst instead of __initdata for ab5500") from the
mfd tree and commit f76facc2354b ("mfd/ab5500: delete AB5500 support")
from the arm-soc tree.

The latter removes the file, so I did that.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120501/7717e97c/attachment.sig>
