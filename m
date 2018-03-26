From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Mar 2018 09:10:26 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20180327091026.3facbb9d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in:

  arch/arm/configs/mxs_defconfig

between commit:

  e3e583e7a293 ("ARM: mxs_defconfig: Re-sync defconfig")

from the arm-soc tree and commit:

  8bc2c29b550c ("ARM: mxs_defconfig: Re-sync defconfig")

from the imx-mxs tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/bde2c949/attachment.sig>
