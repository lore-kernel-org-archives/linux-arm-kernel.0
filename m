From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Apr 2017 10:54:05 +1000
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
Message-ID: <20170421105405.6a690b35@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  include/dt-bindings/genpd/k2g.h

between commit:

  7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains")

from the arm-soc tree and commit:

  45da8edd1741 ("dt-bindings: Add TI SCI PM Domains")

from the pm tree.

I fixed it up (I just used the pm tree version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
