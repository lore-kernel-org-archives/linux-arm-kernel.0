From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Apr 2017 08:38:17 +1000
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
Message-ID: <20170420083817.5a44b69c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Today's linux-next merge of the at91 tree got a conflict in:

  arch/arm/boot/dts/at91-tse850-3.dts

between commit:

  e67cedc92812 ("ARM: dts: at91: add envelope detector mux to the Axentia TSE-850")

from the arm-soc tree and commit:

  29dd89418007 ("ARM: dts: at91: add envelope detector mux to the Axentia TSE-850")

from the at91 tree.

I fixed it up (I used the arm-soc tree version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
