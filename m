From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 25 Jul 2014 10:13:55 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20140725101355.7946e4b9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-integrator/include/mach/memory.h between commit
3ae4e9812941 ("ARM: 8113/1: remove remaining definitions of
PLAT_PHYS_OFFSET from <mach/memory.h>") from the arm tree and commit
e6dc195c1c69 ("ARM: integrator: get rid of <mach/memory.h>") from the
arm-soc tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/407f7426/attachment.sig>
