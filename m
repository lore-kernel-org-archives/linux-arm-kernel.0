From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:37:24 +1000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20120925163724.703a41b9438fbaef84b7480e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
Documentation/devicetree/bindings/usb/platform-uhci.txt between commit
100d45970327 ("ARM: vt8500: Add support for UHCI companion controller")
from the usb tree and commit 95e9fd10f06c ("arm: vt8500: doc: Add device
tree bindings for arch-vt8500 devices") from the arm-soc tree.

I used the version from the arm-soc tree and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/92e733c1/attachment.sig>
