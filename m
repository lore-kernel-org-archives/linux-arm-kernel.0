From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Apr 2017 10:50:53 +1000
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
Message-ID: <20170421105053.5df25205@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in:

  drivers/soc/ti/ti_sci_pm_domains.c

between commit:

  52835d59fc6c ("soc: ti: Add ti_sci_pm_domains driver")

from the arm-soc tree and commit:

  112572283742 ("soc: ti: Add ti_sci_pm_domains driver")

from the pm tree.

I fixed it up (I used the pm tree version, but it was an arbitrary
choice as the only difference is the URL in the Copyright line) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
