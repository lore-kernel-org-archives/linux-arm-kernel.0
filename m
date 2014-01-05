From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jan 2014 10:49:38 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the  tree
Message-ID: <20140106104938.82a53f6d3b4d773607fe7556@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/boot/dts/imx6q-sabrelite.dts between commit 8f568b496dd9 ("ARM:
imx: Explicitly pass the active level of the PHY reset") from the arm-soc
tree and commit e5a5af250568 ("ARM: dts: imx: sabrelite: add Dual
Lite/Solo support") from the imx-mxs tree.

I fixed it up (just used the latter) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/c8c55486/attachment-0001.sig>
