From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 3 Feb 2015 16:31:40 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20150203163140.3edfe607@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/mach-omap2/cclock3xxx_data.c between commit ca662ee7b8a8
("ARM: OMAP2+: Remove unused ti81xx platform init code") from the
arm-soc tree and commit d6540b193719 ("ARM: OMAP3: remove legacy clock
data") from the clk tree.

I fixed it up (the latter removed the file, so I did that) and can
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/6341502c/attachment.sig>
