From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 24 Jun 2015 13:31:33 +1000
Subject: linux-next: manual merge of the dt-rh tree with the arm-soc tree
Message-ID: <20150624133133.435a979d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the dt-rh tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.txt

between commit:

  d5553cb05a04 ("ARM: dts: zx: add an initial zx296702 dts and doc")

from the arm-soc tree and commit:

  72d942e23cda ("of: Add vendor prefix for Zodiac Inflight Innovations")

from the dt-rh tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
index a0aa80bb3480,c400c95abc67..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@@ -225,4 -211,4 +225,5 @@@ xillybus	Xillybus Ltd
  xlnx	Xilinx
  zyxel	ZyXEL Communications Corp.
  zarlink	Zarlink Semiconductor
+ zii	Zodiac Inflight Innovations
 +zte	ZTE Corp.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150624/db857e71/attachment.sig>
