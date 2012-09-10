From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 10 Sep 2012 16:14:28 +1000
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20120910161428.879618aea62e5be6340ed93c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/mach-ux500/clock.c between commit 79964bcd792f ("ARM: ux500:
Correct Ux500 family names usage") from the arm-soc tree and commit
ebc96db7632f ("ARM: ux500: Switch to use common clock framework") from
the clk tree.

The latter removed the file so I did that - there may be more fixup
required.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120910/d4485879/attachment.sig>
