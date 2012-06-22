From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 22 Jun 2012 12:39:04 -0600 (MDT)
Subject: [PATCHv5 5/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
In-Reply-To: <4FE45ACF.3070200@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <1331046702-2472-6-git-send-email-t-kristo@ti.com> <4FE45ACF.3070200@ti.com>
Message-ID: <alpine.DEB.2.00.1206221237290.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> While testing with one of Tero's OMAP4 OFF mode support branches (which
> also include these patches) I found a OMAP4 standalone build fails
> here..
> 
> CC      arch/arm/mach-omap2/omap_hwmod.o
> arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
> arch/arm/mach-omap2/omap_hwmod.c:1797: error: implicit declaration of function
> 'omap3xxx_prm_reconfigure_io_chain'
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

This should be fixed by Kevin's "ARM: OMAP2+: PRM: fix compile for 
OMAP4-only build" patch, part of the following pull request:

http://marc.info/?l=linux-omap&m=134037965609802&w=2


- Paul
