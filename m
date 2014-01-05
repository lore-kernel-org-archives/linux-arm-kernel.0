From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jan 2014 10:42:27 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20140106104227.6cbe4b16e2fe4120a7e1c51a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/boot/dts/imx51-apf51.dts between commit 8f568b496dd9 ("ARM: imx:
Explicitly pass the active level of the PHY reset") from the arm-soc tree
and commit 756c8d5762c2 ("ARM: dts: i.MX51 boards: Switch to use standard
GPIO flags definitions") from the imx-mxs tree.

I fixed it up (again, I arbitrarily chose to go with the latter) and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/5c865575/attachment-0001.sig>
