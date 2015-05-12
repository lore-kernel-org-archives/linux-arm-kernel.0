From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 May 2015 16:02:07 -0700
Subject: [PATCH] MAINTAINERS: add brcmstb regex
In-Reply-To: <1426727345-5838-1-git-send-email-computersforpeace@gmail.com>
References: <1426727345-5838-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <20150512230207.GB11598@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 06:09:05PM -0700, Brian Norris wrote:
> This could probably consolidate a few file listings. And it satisfies
> the spirit of the highly annoying [1] checkpatch warning for every new
> file, though it sadly won't quash it.
> 
> [1] https://lkml.org/lkml/2014/12/17/24
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Ping? Is this a good entry?

One problem is that there may be 'brcmstb' drivers for MIPS as well as
ARM. But on that train of thought: there are several drivers which are
already somewhat inaccurately-listed. The following are listed under
either the BCM7XXX ARM subarchitecture or BMIPS MIPS subarchitecture,
though they are actually used on both:

 drivers/bus/brcmstb_gisb.c
 drivers/irqchip/irq-brcmstb-l2.c
 drivers/irqchip/irq-bcm7120-l2.c

Brian

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e1abe8cc684..52a1cf7cd18a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2179,6 +2179,7 @@ S:	Maintained
>  F:	arch/arm/mach-bcm/*brcmstb*
>  F:	arch/arm/boot/dts/bcm7*.dts*
>  F:	drivers/bus/brcmstb_gisb.c
> +N:	brcmstb
>  
>  BROADCOM BMIPS MIPS ARCHITECTURE
>  M:	Kevin Cernekee <cernekee@gmail.com>
> -- 
> 1.9.1
> 
