From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 22 May 2014 12:12:50 +1000
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20140522121250.0648dfec@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
arch/arm/boot/dts/r8a7790-lager.dts between commit 637193b2f22c ("Merge
branch 'next/boards' into for-next") from the arm-soc tree and commit
2a3bd7497db1 ("Merge branch 'heads/dt-scif-for-v3.16' into next") from
the renesas tree.

I fixed it up (I used the latter since it kept the trailing semi-colon)
and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/fdd5631d/attachment.sig>
