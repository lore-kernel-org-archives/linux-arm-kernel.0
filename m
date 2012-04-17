From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 17 Apr 2012 13:34:18 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20120417133418.2280ccb3897436e6c8e82398@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-generic.c between commit aa1d7775696c ("mfd:
Convert twl6040 to i2c driver, and separate it from twl core") from the
mfd tree and commit 93651b85bbd1 ("ARM: OMAP2+: board-generic: Remove i2c
static init") from the arm-soc tree.

The latter seems to supercede the former, so I used that.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120417/d853f3fa/attachment.sig>
