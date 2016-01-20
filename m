From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 21 Jan 2016 09:40:22 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20160121094022.33e25d08@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  MAINTAINERS

between commit:

  4a121096db9c ("MAINTAINERS: Update mailing list for Renesas SoC Development")

from Linus' tree and commit:

  804b0d7011ee ("MAINTAINERS: Remove link to oss.renesas.com which is closed")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc MAINTAINERS
index 5461ecc147dc,0939ce1bdb71..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1531,9 -1526,8 +1541,8 @@@ F:	drivers/media/platform/s5p-jpeg
  ARM/SHMOBILE ARM ARCHITECTURE
  M:	Simon Horman <horms@verge.net.au>
  M:	Magnus Damm <magnus.damm@gmail.com>
 -L:	linux-sh at vger.kernel.org
 -Q:	http://patchwork.kernel.org/project/linux-sh/list/
 +L:	linux-renesas-soc at vger.kernel.org
- W:	http://oss.renesas.com
 +Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
  S:	Supported
  F:	arch/arm/boot/dts/emev2*
