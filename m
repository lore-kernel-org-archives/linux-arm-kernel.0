From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jul 2014 11:35:11 +0200
Subject: [GIT PULL] omap soc changes for v3.17 merge window
In-Reply-To: <20140724115850.GC29045@atomide.com>
References: <20140724115850.GC29045@atomide.com>
Message-ID: <5148043.QCGen0hlse@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 July 2014 04:58:50 Tony Lindgren wrote:
> SoC related changes for omaps for v3.17 merge window:
> 
> - Add device tree and hwmod data for various devices
>   for new SoCs
> 
> - Remove legacy mailbox hwmod data that's no longer
>   needed for SoCs that are DT only. Note that this may
>   cause a minor merge conflict in mach-omap2/devices.c
>   with omap_init_mbox() and omap_init_hdmi_audio(), both
>   are legacy code that is getting removed

Very good, merged into next/soc. Thanks,

	Arnd
