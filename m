From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 10 Sep 2010 08:04:15 -0700
Subject: [PATCH 1/4] arm: Kconfig option for ARCH_MSM_SCORPIONMP
In-Reply-To: <20100910145137.GB20509@pengutronix.de>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-2-git-send-email-dwalker@codeaurora.org>
	<4C8A0501.6080902@ru.mvista.com>
	<20100910145137.GB20509@pengutronix.de>
Message-ID: <1284131055.21256.6.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-09-10 at 16:51 +0200, Uwe Kleine-K?nig wrote:
> Hello Sergei,
> 
> On Fri, Sep 10, 2010 at 02:14:25PM +0400, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 09-09-2010 23:58, Daniel Walker wrote:
> >
> >> From: Steve Muckle<smuckle@codeaurora.org>
> >
> >> ScorpionMP is a configuration of Scorpion processors. It supports local
> >> timers.
> >
> >> Signed-off-by: Steve Muckle<smuckle@codeaurora.org>
> >> Signed-off-by: Jeff Ohlstein<johlstei@codeaurora.org>
> >> Signed-off-by: Daniel Walker<dwalker@codeaurora.org>
> > [...]
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index a7ed21f..d2dfbc2 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1144,7 +1144,8 @@ config SMP
> >>   	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
> >>   	depends on EXPERIMENTAL&&  (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
> >>   		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
> >> -		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
> >> +		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4||\
> >> +		 ARCH_MSM_SCORPIONMP)
> >>   	depends on GENERIC_CLOCKEVENTS
> >>   	select USE_GENERIC_SMP_HELPERS
> >>   	select HAVE_ARM_SCU if ARCH_REALVIEW || ARCH_OMAP4 || ARCH_S5PV310 ||\
> >> @@ -1218,7 +1219,8 @@ config LOCAL_TIMERS
> >>   	bool "Use local timer interrupts"
> >>   	depends on SMP&&  (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
> >>   		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> >> -		ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
> >> +		ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 ||\
> >
> >    Could you put spce before \ to keep the style consistent?
> It's at least locally consistent, isn't it?


It's sort of depends which line you look at, some have spaces some
don't. I can send an additional patch to make it all consistent.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
