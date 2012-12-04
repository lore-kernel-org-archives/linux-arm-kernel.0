From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Dec 2012 15:42:03 +1100
Subject: linux-next: manual merge of the arm-soc tree with the iommu tree
Message-ID: <20121204154203.f0e7e87d1ae99e5c528434f8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/clock44xx_data.c between commit 298ea44f211d ("ARM:
OMAP4: hwmod data: ipu and dsp to use parent clocks instead of leaf
clocks") from the iommu tree and commit 13a5b6228679 ("ARM: OMAP44xx:
clock: drop obsolete clock data") from the arm-soc tree.

I just deleted the file as the latter did and can carry the fix as
necessary (no action is required).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121204/3c83aa90/attachment.sig>
