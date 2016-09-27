From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Sep 2016 15:05:42 +1000
Subject: linux-next: manual merge of the gpio tree with the arm-soc tree
Message-ID: <20160927150542.7e81e7ee@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Today's linux-next merge of the gpio tree got a conflict in:

  arch/arm/mach-omap2/board-rx51-peripherals.c

between commit:

  9b7141d01a76 ("ARM: OMAP2+: Drop legacy board file for n900")

from the arm-soc tree and commit:

  9132ce450bd1 ("ARM: omap2: fix missing include")

from the gpio tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
