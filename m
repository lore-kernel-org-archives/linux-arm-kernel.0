From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Jul 2014 12:06:31 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140717120631.4bc75d13@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got conflicts in
arch/arm/mach-s5pv210/dev-audio.c,
arch/arm/mach-s5pv210/include/mach/gpio-samsung.h,
arch/arm/mach-s5pv210/mach-aquila.c, arch/arm/mach-s5pv210/mach-goni.c,
arch/arm/mach-s5pv210/mach-smdkv210.c,
arch/arm/mach-s5pv210/setup-fb-24bpp.c,
arch/arm/mach-s5pv210/setup-fimc.c, arch/arm/mach-s5pv210/setup-i2c0.c,
arch/arm/mach-s5pv210/setup-i2c1.c, arch/arm/mach-s5pv210/setup-i2c2.c,
arch/arm/mach-s5pv210/setup-ide.c,
arch/arm/mach-s5pv210/setup-keypad.c,
arch/arm/mach-s5pv210/setup-sdhci-gpio.c,
arch/arm/mach-s5pv210/setup-spi.c and
arch/arm/plat-samsung/s5p-irq-eint.c between commit 2fd48f94426d ("ARM:
mach-s5p: get rid of all <mach/gpio.h> headers") from the arm-soc tree
and commits 36278bb98dc7 ("ARM: S5PV210: Remove support for board
files") and 2722091e711f ("ARM: SAMSUNG: Remove remaining legacy code")
from the samsung tree.

I fixed it up (I just removed the files removed by the latter commits)
and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/c2201735/attachment.sig>
