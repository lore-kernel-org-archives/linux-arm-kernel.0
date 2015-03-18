From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 18 Mar 2015 12:03:47 +1100
Subject: linux-next: manual merge of the slave-dma tree with the arm-soc tree
Message-ID: <20150318120347.21288162@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Today's linux-next merge of the slave-dma tree got a conflict in
arch/arm/mach-shmobile/board-mackerel.c between commit a521422ea4ae
("ARM: shmobile: mackerel: Remove Legacy C board code") from the
arm-soc tree and commit c078c62a7528 ("mmc: sh_mobile_sdhi: remove
sh_mobile_sdhi_info v2") from the slave-dma tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/ff5833ce/attachment.sig>
