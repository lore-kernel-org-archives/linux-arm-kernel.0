From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 Jul 2014 11:06:05 +1000
Subject: linux-next: manual merge of the mvebu tree with Linus' tree
Message-ID: <20140714110605.045e5cf5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/Kconfig between commit 19682f72f5db ("ARM: Remove
ARCH_HAS_CPUFREQ config option") from Linus' tree and commit
ba364fc752da ("ARM: Kirkwood: Remove mach-kirkwood") from the mvebu
tree.

I fixed it up (The latter just removed the whole ARCH_KIRKWOOD entry,
so I did that) and can carry the fix as necessary (no action is
required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/6a985e7b/attachment.sig>
