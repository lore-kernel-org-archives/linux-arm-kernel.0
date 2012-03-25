From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Mar 2012 11:50:54 +0100
Subject: [GIT PULL 0/9] arm-soc updates, first batch
In-Reply-To: <1332626568-17812-1-git-send-email-arnd@arndb.de>
References: <1332626568-17812-1-git-send-email-arnd@arndb.de>
Message-ID: <20120325105054.GD5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2012 at 10:02:37PM +0000, Arnd Bergmann wrote:
> Rob Herring (29):
>       ARM: timer-sp: add sched_clock support
>       ARM: highbank: enable sp804 based sched_clock
>       ARM: highbank: remove unused memory.h
>       Merge remote-tracking branch 'arm-soc/at91/base2+cleanup' into cleanup-base
>       usb: ohci-pxa27x: add explicit include of hardware.h
>       ARM: provide runtime hook for ioremap/iounmap
>       ARM: imx: convert to common runtime ioremap hook
>       ARM: msm: use runtime ioremap hook
>       ARM: iop13xx: use runtime ioremap hook
>       ARM: ixp4xx: use runtime ioremap hook
>       ARM: ebsa110: use runtime ioremap hook
>       ARM: remove compile time __arch_ioremap/__arch_iounmap
>       ARM: iop13xx: move io.h externs to pci.h
>       ARM: msm: clean-up mach/io.h
>       [media] davinci: remove includes of mach/io.h
>       ARM: davinci: remove unneeded mach/io.h include
>       ARM: orion5x: clean-up mach/io.h
>       ARM: tegra: clean-up mach/io.h
>       ARM: ep93xx: clean-up mach/io.h
>       ARM: at91: add explicit include of hardware.h to uncompressor
>       ARM: dove: add explicit include of dove.h to addr-map.c
>       ARM: clps711x: remove unneeded include of mach/io.h
>       ARM: make mach/io.h include optional
>       ARM: remove bunch of now unused mach/io.h files
>       ARM: kill off __mem_pci
>       ARM: fix ioremap/iounmap for !CONFIG_MMU
>       ARM: iop13xx: fix missing declaration of iop13xx_init_early
>       ARM: create a common IOMEM definition
>       ARM: __io abuse cleanup

Arnd, I assume this shortlog is for the entire arm-soc queue rather than
this set of 9 pull requests?  If so fine.

If not, I couldn't find Rob's IO stuff in this set of 9 pulls - at the
moment because PXA currently fails to build because of that, and there's
a couple of patches on the list from Rob sent on the 20th to solve that.
However, Rob hasn't sent them to you yet.  I've already prodded over them
to try and find out what's happening.
