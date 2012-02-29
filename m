From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 21:08:29 +0000
Subject: [GIT PULL 4/5] First round of DT related omap changes
In-Reply-To: <0Luuob-1STTV50YM5-00zayn@mx.kundenserver.de>
References: <0Luuob-1STTV50YM5-00zayn@mx.kundenserver.de>
Message-ID: <201202292108.29906.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Tony Lindgren wrote:
> Benoit Cousson (10):
>       arm/dts: OMAP: Remove bootargs node from board files
>       ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems
>       ARM: OMAP2+: board-generic: Remove un-needed .atag_offset for DT_MACHINE
>       ARM: OMAP2+: omap_device: Replace dev_warn by dev_dbg in omap_device_build_from_dt
>       ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
>       ARM: OMAP1: kconfig: Enable IRQ_DOMAIN by default for OMAP1 platforms
>       arm/dts: OMAP3&4: Remove the '0x' prefix for serial nodes
>       arm/dts: OMAP4: Add i2c controller nodes
>       arm/dts: OMAP3: Add i2c controller nodes
>       arm/dts: OMAP4: Update DTS file with new GIC bindings
> 
> Tony Lindgren (3):
>       Merge branch 'for_3.4/dt_base' of git://git.kernel.org/.../bcousson/linux-omap-dt into dt
>       ARM: OMAP2+: Set Kconfig dependencies for PROC_DEVICETREE
>       Merge branch 'for_3.4/dts_updates' of git://git.kernel.org/.../bcousson/linux-omap-dt into dt
> 
> Vaibhav Hiremath (1):
>       arm/dts: Add support for TI OMAP3 EVM board

Pulled into next/dt. Thanks,

	Arnd
