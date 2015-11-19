From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 00:59:13 +0800
Subject: [PATCH RESEND] arm64: berlin: add the pinctrl dependency for
 Marvell Berlin SoCs
In-Reply-To: <20151117134154.GJ6556@e104818-lin.cambridge.arm.com>
References: <1447670170-7597-1-git-send-email-jszhang@marvell.com>
 <20151117134154.GJ6556@e104818-lin.cambridge.arm.com>
Message-ID: <20151120005913.3f57a5e8@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015 13:41:54 +0000
Catalin Marinas wrote:

> On Mon, Nov 16, 2015 at 06:36:10PM +0800, Jisheng Zhang wrote:
> > This is to add the pinctrl dependency for Marvell Berlin SoCs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  this small patch is missed:
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378638.html
> >  arch/arm64/Kconfig.platforms | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 4043c35..905d308 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -9,6 +9,7 @@ config ARCH_BERLIN
> >  	bool "Marvell Berlin SoC Family"
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select DW_APB_ICTL
> > +	select PINCTRL
> >  	help
> >  	  This enables support for Marvell Berlin SoC Family  
> 
> Cc'ing arm-soc.
> 

Dear Sebastian,

when adding clk support for BG4CT, I found

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378634.html
and
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378635.html

are also missed in v4.4-rc1.

I know you are very busy but I dunno what's wrong. Can you please check?

Thanks in advance,
Jisheng
