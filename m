From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 18 Jun 2013 16:12:39 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130618161239.5ce92432180d9418831d2514@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/usb/phy/phy-rcar-usb.c between commit 56a9a6de2a87 ("usb: phy:
rcar-usb: Fix comment w.r.t. devm_ioremap_resource") from the usb tree
and commit 725bf9dcafe1 ("phy-rcar-usb: correct base address") from the
arm-soc tree.

I fixed it up (The latter removed the comment corrected by the former)
and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/72308bc1/attachment.sig>
