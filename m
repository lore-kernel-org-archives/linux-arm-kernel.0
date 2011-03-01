From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Feb 2011 17:10:16 -0700 (MST)
Subject: [PATCH] omap3: fix compile-time warnings
In-Reply-To: <1297415100-15912-1-git-send-email-premi@ti.com>
References: <1297415100-15912-1-git-send-email-premi@ti.com>
Message-ID: <alpine.DEB.2.00.1102281709330.29478@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Feb 2011, Sanjeev Premi wrote:

> This patch fixes these warnings when building kernel for OMAP3EVM
> only.
> 
>   CC      arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.o
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning:
>  'dsp_24xx_wkdeps' defined but not used
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning:
>  'mpu_24xx_wkdeps' defined but not used
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning:
>  'core_24xx_wkdeps' defined but not used
> 
> The problem should be noticed when building for other OMAP3
> platforms (only) as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>

I just noticed this patch when digging through Patchwork.  I've dropped my 
(later) patch which does the same thing and applied this one instead for 
the 2.6.39 queue.


- Paul
