From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 18 Mar 2014 11:21:38 +1100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20140318112138.75a24ca8a0719d5b3fb98720@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/boot/dts/Makefile between commit 8fc1b0f87d9f ("ARM: qcom: Split
Qualcomm support into legacy and multiplatform") from the arm-soc tree
and commits 97623e934388 ("Merge branch 'mvebu/dt' into for-next") and
54cab10f63f2 ("Merge branch 'mvebu/soc3' into next/dt") from the mvebu
tree.

I fixed it up (which produced no git diff) and can carry the fix as
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/74ddaf2c/attachment.sig>
