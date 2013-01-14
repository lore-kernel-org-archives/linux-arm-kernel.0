From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 Jan 2013 13:49:08 +1100
Subject: linux-next: manual merge of the arm-soc tree with the crypto tree
Message-ID: <20130114134908.094003722be0612c20574338@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/crypto/omap-sham.c between commit dfd061d5a8f5 ("crypto:
omap-sham - Add code to use dmaengine API") from the crypto tree and
commit a62a6e98c370 ("ARM: OMAP2+: Disable code that currently does not
work with multiplaform") from the arm-soc tree.

I fixed it up (the former removed the include that the latter protected)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/2e719d0a/attachment-0001.sig>
