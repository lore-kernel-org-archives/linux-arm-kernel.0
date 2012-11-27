From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:44:30 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20121127154430.36e87542081a7cc50f80d0f6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-spear13xx/spear1310.c between commit b47394911c26 ("ARM:
SPEAr13xx: Pass DW DMAC platform data from DT") from the slave-dma tree
and commit 300a6856324a ("ARM: SPEAr1310: Fix AUXDATA for compact flash
controller") from the arm-soc tree.

I have no idea how to fix this up, so I just effectively dropped the
arm-doc tree patch.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/967eabbd/attachment-0001.sig>
