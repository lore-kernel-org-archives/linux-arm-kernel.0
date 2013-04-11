From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 11 Apr 2013 16:21:21 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm-current tree
Message-ID: <20130411162121.02448747195d0d5fa6ce0124@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/configs/h7201_defconfig and arch/arm/configs/h7202_defconfig
between commit e42c3074c8f7 ("ARM: remove NWFPE and VFP emulation code
from the kernel") from the arm-current tree and commit 293eb135a924
("ARM: kill Hynix h720x platform") from the arm-soc tree.

The latter deleted the files, so I did that and can carry the fix as
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/0ab6cbd7/attachment.sig>
