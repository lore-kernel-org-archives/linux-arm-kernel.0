From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jun 2010 08:51:29 -0500
Subject: [PATCH 01/10] [ARM] tegra: initial tegra support
In-Reply-To: <AANLkTinPJuvApEVRdx5M6Oi88_-avWr_Q63atSOfTruK@mail.gmail.com>
References: <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<AANLkTinPJuvApEVRdx5M6Oi88_-avWr_Q63atSOfTruK@mail.gmail.com>
Message-ID: <20100611135129.GA15108@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 08, 2010 at 01:34:25AM +0200, Linus Walleij wrote:
> 2010/6/4 Olof Johansson <olof@lixom.net>:
> 
> > (...)
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 5bd7c89..b4f6c5e 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -760,7 +760,7 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
> > ?config CACHE_L2X0
> > ? ? ? ?bool "Enable the L2x0 outer cache controller"
> > ? ? ? ?depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
> > - ? ? ? ? ? ? ? ? ?REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
> > + ? ? ? ? ? ? ? ? ?REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4 || ARCH_TEGRA
> 
> What are you actually basing your patches on? You will
> need to bring your patches to the head, there are already
> two more machines using the L2x0 for example, so this
> won't apply.

Yeah, I messed up and accidentally based it on .34 instead of current
-rc at time of posting.

Erik and Colin have rebased properly and folded in the changes from your
other comments. I'll leave it up to them but you should see an email
about it at some point.


-Olof
