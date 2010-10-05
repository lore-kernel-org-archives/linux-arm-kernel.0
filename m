From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Oct 2010 17:15:21 -0700
Subject: [GIT PULL v2] OMAP: SCM/McBSP/clock: branch integration
	patches for 2.6.37
In-Reply-To: <alpine.DEB.2.00.1010041339330.13816@utopia.booyaka.com>
References: <alpine.DEB.2.00.1010022010190.22941@utopia.booyaka.com>
	<alpine.DEB.2.00.1010041339330.13816@utopia.booyaka.com>
Message-ID: <20101005001520.GB3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [101004 12:32]:
> 
> Hi Tony,
> 
> here's the updated pull request for this branch, with comments integrated.
> 
> The following changes since commit 7ad0e386d46e9edff64705ab25337ad9130baf63:
> 
>   OMAP2+: defconfig: disable CPUfreq (2010-09-29 10:39:02 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 control_mcbsp_fix_2.6.37
> 
> Paul Walmsley (10):
>       OMAP2+: Kconfig: disallow builds for boards that don't use the currently-selected SoC
>       OMAP2420: CTRL: fix OMAP242X_CTRL_REGADDR macro
>       OMAP2420: clock: add MCBSP_CLKS node and clkdev aliases
>       OMAP2430: clock: add MCBSP_CLKS node and clkdev aliases
>       OMAP3xxx: clock: add clkdev aliases for McBSP fclk source switching
>       OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c
>       OMAP: McBSP: implement functional clock switching via clock framework
>       OMAP: split plat-omap/common.c
>       OMAP: control: move plat-omap/control.h to mach-omap2/control.h
>       OMAP2+: clock: reduce the amount of standard debugging while disabling unused clocks

Thanks, pulling these into omap-for-linus.

Regards,

Tony
