From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 10 Jan 2012 11:52:18 +1100
Subject: linux-next: please update the i.MX tree
Message-ID: <20120110115218.e00ab8c01abd5b9ae9a3b166@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

It looks like most (if not all) of the i.MX tree has been merged into the
arm-soc (and Linus') tree, so could you please update the i.MX tree to
eliminate the conflicts I am getting.

CONFLICT (content): Merge conflict in arch/arm/plat-mxc/include/mach/hardware.h
CONFLICT (modify/delete): arch/arm/mach-mx5/pm-imx5.c deleted in HEAD and modified in i.MX/for-next. Version i.MX/for-next of arch/arm/mach-mx5/pm-imx5.c left in tree.
CONFLICT (modify/delete): arch/arm/mach-mx5/Makefile deleted in HEAD and modified in i.MX/for-next. Version i.MX/for-next of arch/arm/mach-mx5/Makefile left in tree.
CONFLICT (modify/delete): arch/arm/mach-mx5/Kconfig deleted in HEAD and modified in i.MX/for-next. Version i.MX/for-next of arch/arm/mach-mx5/Kconfig left in tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120110/4779a8e2/attachment.sig>
