From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 May 2014 15:17:58 +1000
Subject: linux-next: manual merge of the trivial tree with the arm-soc tree
Message-ID: <20140527151758.00163ea0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri,

Today's linux-next merge of the trivial tree got a conflict in
Documentation/devicetree/bindings/arm/omap/omap.txt between commit
38b248db60e3 ("ARM: dts: Add support for DRA72x family of devices")
from the arm-soc tree and commit c98be0c96db0 ("doc: spelling error
changes") from the trivial tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/arm/omap/omap.txt
index 189baba40cd6,aa71962352ff..000000000000
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@@ -126,11 -114,5 +126,11 @@@ Boards
  - AM43x EPOS EVM
    compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
  
 -- DRA7 EVM:  Software Development Board for DRA7XX
 -  compatible = "ti,dra7-evm", "ti,dra7"
 +- AM437x GP EVM
 +  compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
 +
- - DRA742 EVM:  Software Developement Board for DRA742
++- DRA742 EVM:  Software Development Board for DRA742
 +  compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
 +
 +- DRA722 EVM: Software Development Board for DRA722
 +  compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/8d042811/attachment.sig>
