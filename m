From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Apr 2013 17:47:47 +1000
Subject: linux-next: manual merge of the arm-soc tree with the gpio-lw tree
Message-ID: <20130409174747.873a9c9cad1cd6a4dbe4014f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/gpio/gpio-vt8500.c between commit 808c513ee64b ("gpio/vt8500:
Convert to devm_ioremap_resource()") from the gpio-lw tree and commit
dc1010860b03 ("gpio: vt8500: Remove arch-vt8500 gpio driver") from the
arm-soc tree.

The latter removed the file, so I did that and can carry the fix as
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/21456e74/attachment.sig>
