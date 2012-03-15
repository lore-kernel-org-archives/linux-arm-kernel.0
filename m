From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 17:50:00 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20120315175000.897f1172c296d4a687be0537@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/board-mackerel.c between commit 1740d3448012
("ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer")
from Linus' tree and commit 5d7220ec000f ("ARM: mach-shmobile: sh7372
map_io and init_early update") from the arm-soc tree.

The latter moved the code to another file
arch/arm/mach-shmobile/setup-sh7372.c and I have no idea how to fix this
up, so I just removed the change done by the former.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/00a62592/attachment.sig>
