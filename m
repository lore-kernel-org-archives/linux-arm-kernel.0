From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 16 Jan 2011 11:00:42 -0700 (MST)
Subject: [PATCH 2/2] arm: omap: remove duplicated headers
In-Reply-To: <1295174783-4099-2-git-send-email-balbi@ti.com>
References: <1295174783-4099-1-git-send-email-balbi@ti.com>
	<1295174783-4099-2-git-send-email-balbi@ti.com>
Message-ID: <alpine.DEB.2.00.1101161059190.13225@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 16 Jan 2011, Felipe Balbi wrote:

> A few headers are included twice, remove them.
> 
> Found the following errors using make includecheck:
> arch/arm/mach-omap2/clock44xx_data.c: prm44xx.h is
> included more than once.
> arch/arm/mach-omap2/clockdomains44xx_data.c: cm1_44xx.h
> is included more than once.
> arch/arm/mach-omap2/clockdomains44xx_data.c: cm2_44xx.h
> is included more than once.
> arch/arm/mach-omap2/powerdomain2xxx_3xxx.c: prm-regbits-34xx.h
> is included more than once.

These are probably merge-related.  I'll take this patch for 2.6.38-rc.

Thanks,


- Paul
