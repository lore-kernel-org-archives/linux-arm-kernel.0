From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 20 Sep 2016 10:19:38 +1000
Subject: linux-next: manual merge of the amlogic tree with the arm-soc tree
Message-ID: <20160920101938.5d46a0ab@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the amlogic tree got a conflict in:

  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi

between commit:

  8735053d7968 ("ARM64: dts: meson-gxbb-p20x: Enable USB Nodes")

from the arm-soc tree and commit:

  d82801a385a1 ("ARM64: dts: meson-gxbb-p20x: Enable USB Nodes")

from the amlogic tree.

This patch was modified before being merged into the arm-soc tree.
Please clean up the amlogic tree.

I fixed it up (I used the arm-soc tree version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

-- 
Cheers,
Stephen Rothwell
