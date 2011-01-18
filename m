From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 15:53:02 +0000
Subject: [PATCH V4 00/62] Updating SPEAr Support
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <20110118155302.GA16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 12:41:28PM +0530, Viresh Kumar wrote:
> Changes since V3:
> - SPEAr13xx: gic init, smp and hotplug code updated w.r.t. latest linus/master
> - Appending UL to VMALLOC_END Macros
> - readl & writle _relaxed used instread _raw in uncompress.h
> - infinite loop removed from arch_reset() in
>   mach-spear13xx/include/mach/system.h
> - patch: ST-SPEAr13xx-Modified-static-mappings is broken into two patches.
>   Now, static mapping for SPEAr1310 RAS will be present only on 1310 machine.
> - Updated commit message of: SPEAr Power Management: Added the support for
>   Standby mode
> - Default ssp freq changed to 25MHz.
> - patch: ST-SPEAr-13xx-Adding-support-for-SPEAr1310 is splitted into two
>   patches. Separate patch for 320 CAN is added.
> - Wrapper routine spi_init() in spear*evb.c files is removed.
> - routine i2c_register_board_devices() is renamed to
>   i2c_register_default_devices() in arch/arm/plat-spear/i2c_eval_board.c file
> - Following patches are removed from this patchset, they will be added
>   separately:
> 	ST-SPEAr-FSMC-Flexible-Static-Memory-Controller-NOR-.patch
> - Following patches are already present in linus-next or already Acked, so they
>   are also removed from this patchset:
> 	Newly-erased-page-read-workaround.patch

Does this mean I can get rid of the entire set of spear patches in the
patch system now?
