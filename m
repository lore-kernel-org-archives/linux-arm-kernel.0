From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Apr 2013 19:09:00 +1000
Subject: linux-next: build warning after merge of the final tree (probably
 arm-soc tree related)
Message-ID: <20130409190900.97dcf3a70a9c0ad727b8bc4b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the final tree, today's linux-next build (arm defconfig)
produced these warnings:

arch/arm/mach-cns3xxx/Kconfig:2:warning: choice value used outside its choice group
arch/arm/mach-bcm2835/Kconfig:2:warning: choice value used outside its choice group
arch/arm/Kconfig:287:error: recursive dependency detected!
arch/arm/Kconfig:287:	choice <choice> contains symbol ARCH_CNS3XXX
arch/arm/Kconfig:366:	symbol ARCH_CNS3XXX depends on ARCH_MULTI_V6
arch/arm/Kconfig:933:	symbol ARCH_MULTI_V6 depends on ARCH_MULTIPLATFORM
arch/arm/Kconfig:292:	symbol ARCH_MULTIPLATFORM is part of choice <choice>

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/ec45e218/attachment.sig>
