From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 22:19:25 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20121126221925.f6c8bdcbd35718989dd52b5c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/boot/dts/exynos5250.dtsi between commit 24025f6f5821 ("Merge
branch 'next/dt-samsung' of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into
next/dt") from the arm-soc tree and commit 5d706af5ab0b ("Merge branch
'next/dt-samsung' into for-next") from the samsung tree.

I fixed it up (by using the samsung tree version) and can carry the fix
as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/ebbb177f/attachment.sig>
