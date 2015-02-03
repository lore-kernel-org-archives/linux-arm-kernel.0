From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 3 Feb 2015 16:28:19 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20150203162819.5693d5d1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/mach-omap2/io.c between commit c27964b5d2f3 ("ARM: OMAP2+: Fix
ti81xx class type") from the arm-soc tree and commit eded36fe29e1
("ARM: OMAP3: use clock data from TI clock driver for legacy boot")
from the clk tree.

I fixed it up (the former seems to have incorporated the conflicting
part of the latter) and can carry the fix as necessary (no action is
required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/249db117/attachment-0001.sig>
