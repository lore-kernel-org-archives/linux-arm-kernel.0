From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 5 Sep 2016 10:58:03 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20160905105803.13ed27ff@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/mach-realview/core.c

between commit:

  2fb04fdf3019 ("net: smc91x: fix SMC accesses")

from Linus' tree and commit:

  7484c727b636 ("ARM: realview: delete the RealView board files")

from the arm-soc tree.

I fixed it up (I deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
