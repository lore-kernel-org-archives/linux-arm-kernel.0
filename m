From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Apr 2013 15:33:35 +1100
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
Message-ID: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-spear/spear13xx.c between commit c79e33b3e828 ("ARM:
smp_twd: convert to use CLKSRC_OF init") from the xilinx tree and commit
2b9c613c4ee1 ("ARM: spear: move generic.h and pl080.h into private dir")
from the arm-soc tree.

I fixed it up (just used the arm-soc tree version) and can carry the fix
as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/f6f9d41f/attachment-0001.sig>
