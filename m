From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Nov 2014 11:16:34 +1100
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
Message-ID: <20141124111634.1498b6c1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Today's linux-next merge of the sunxi tree got a conflict in
arch/arm/boot/dts/sun6i-a31.dtsi between commit 123ccfcc632a ("Revert
merge of sunxi/dt") from the arm-soc tree and commits from the sunxi
tree.

I fixed it up (I just used the version from the sunxi tree) and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/46e25d22/attachment.sig>
