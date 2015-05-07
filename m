From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 20:20:31 +0100
Subject: [STLinux Kernel] [PATCH 12/12] ARM: STi: Update platform level
 menuconfig 'help'
In-Reply-To: <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-13-git-send-email-lee.jones@linaro.org>
 <20150507141526.GB9793@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150507192031.GD16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 May 2015, Peter Griffin wrote:

> Hi Lee,
> 
> On Thu, 07 May 2015, Lee Jones wrote:
> 
> > Encompass newer STiH4{07,10} SoC based platforms.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/mach-sti/Kconfig | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
> > index cb886de..59928d9 100644
> > --- a/arch/arm/mach-sti/Kconfig
> > +++ b/arch/arm/mach-sti/Kconfig
> > @@ -16,11 +16,9 @@ menuconfig ARCH_STI
> >  	select PL310_ERRATA_769419 if CACHE_L2X0
> >  	select RESET_CONTROLLER
> >  	help
> > -	  Include support for STiH41x SOCs like STiH415/416 using the device tree
> > -	  for discovery
> > -	  More information at Documentation/arm/STiH41x and
> > -	  at Documentation/devicetree
> > -
> > +	  Include support for STMicroelectronics' STiH415/416 and stih407/10
> > +	  family SoCs using the Device Tree for discovery.  More information
> > +	  can be found in Documentation/arm/sti/ & Documentation/devicetree.
> 
> You should use the same capitalisation throughout.

Good spot, that was unintentional.  Will fix.

> Also you can mention STiH418, as that is now supported upstream.

Yep, thanks.

> Once fixed you can add my: -
>      Acked-by: Peter Griffin <peter.griffin@linaro.org>

Ta.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
