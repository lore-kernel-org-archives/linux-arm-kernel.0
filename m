From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Jul 2014 11:39:57 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm tree
Message-ID: <20140717113957.199f8e94@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/mach-mvebu/headsmp-a9.S between commit e77a0969a99e ("ARM:
convert all "mov.* pc, reg" to "bx reg" for ARMv6+") from the arm tree
and commit 435b4642e49f ("ARM: mvebu: use the common function for
Armada 375 SMP workaround") from the mvebu tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/79ba20b0/attachment-0001.sig>
