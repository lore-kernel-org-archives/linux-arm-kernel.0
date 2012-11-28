From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 28 Nov 2012 17:12:07 +1100
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
Message-ID: <20121128171207.e8e19e40f2c43104951d389a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Today's linux-next merge of the clk tree got a conflict in
arch/arm/mach-ux500/cpu-db8500.c between commit e13316d60658 ("ARM:
ux500: Rename dbx500 cpufreq code to be more generic") from the arm-soc
tree and commit 50545e1d237b ("ARM: ux500: Remove cpufreq platform
device") from the clk tree.

I fixed it up (I used the clk tree version since that removed the code
that the arm-soc tree version modified) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121128/f9fffd51/attachment.sig>
