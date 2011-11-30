From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 10:48:43 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <1322587019.3164.111.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <20111129170013.GD2829@localhost.localdomain>
 <1322587019.3164.111.camel@hornet.cambridge.arm.com>
Message-ID: <20111130104842.GA2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 05:16:59PM +0000, Pawel Moll wrote:
> On Tue, 2011-11-29 at 17:00 +0000, Dave Martin wrote:
> > I'm trying to build... what tree are you basing on?
> 
> v3.2-rc3:
> 
> $ git log --oneline HEAD...v3.2-rc3~
> 3b9df1e ARM: vexpress: DT-based support for CoreTiles Express A5x2 and A9x4
> 5a1c565 ARM: vexpress: Initial RS1 memory map support
> 9355e8a ARM: vexpress: Add DT support in v2m
> 0529bd6 ARM: vexpress: Get rid of MMIO_P2V
> 68118cc ARM: versatile: Add missing ENDPROC to headsmp.S
> caca6a0 Linux 3.2-rc3
> 
> > With v3.2-rc3 or next, I get OF header failures like the following:
> > 
> > arch/arm/kernel/devtree.c: In function ?arm_dt_memblock_reserve?:
> > arch/arm/kernel/devtree.c:41:7: error: ?initial_boot_params? undeclared (first use in this function)
> > arch/arm/kernel/devtree.c:41:7: note: each undeclared identifier is reported only once for each function it appears in
> [...]
> 
> Can you send me your config, please?

Attached.  It's just vexpress_defconfig, plus ARCH_VEXPRESS_V2P_CA5S_CA9=y

OK, I'll pull that in too.

Cheers
---Dave
-------------- next part --------------
A non-text attachment was scrubbed...
Name: defconfig.gz
Type: application/octet-stream
Size: 1072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111130/3b99608b/attachment-0001.obj>
