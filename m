From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 17:07:51 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20120308170751.8197b85ec3ab0a95e99ce945@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-vexpress/Kconfig between commit 43a6955fa8c3 ("ARM: 7346/1:
errata: fix PL310 erratum #753970 workaround selection") from Linus' tree
and commit 8deed1786a64 ("ARM: vexpress: Add Device Tree support") from
the arm-soc tree.

The latter took the former into account, so I dropped the former for this
file.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/420c7380/attachment.sig>
