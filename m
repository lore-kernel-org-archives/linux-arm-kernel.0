From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Jun 2013 16:01:14 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20130628160114.b80eb381637462072d7e674c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-exynos/mach-universal_c210.c between commit 555183096fc7
("regulator: max8998: Use arrays for specifying voltages in platform
data") from the mfd tree and commit ca9143501c30 ("ARM: EXYNOS: Remove
unused board files") from the arm-soc tree.

I just removed the file and can carry the fix as necessary (no action is
required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/027e21d6/attachment.sig>
