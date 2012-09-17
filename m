From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 17 Sep 2012 08:14:20 +0000
Subject: [PATCH v9 1/3] ARM: OMAP2/3: hwmod data: add gpmc
In-Reply-To: <alpine.DEB.2.00.1209122202030.7275@utopia.booyaka.com>
References: <cover.1347355380.git.afzal@ti.com>
 <eb0761d198e52ea7d39d201702e1eff84c511396.1347355380.git.afzal@ti.com>
 <alpine.DEB.2.00.1209122202030.7275@utopia.booyaka.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E4DAD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, Sep 13, 2012 at 03:45:27, Paul Walmsley wrote:

> > +				HWMOD_INIT_NO_RESET |

> As I understand it, this is not due to any GPMC-related reset bugs, but 
> just because the kernel is relying on the bootloader GPMC timing data 
> being preserved.  Is that correct?

Yes, it is due to Kernel relying on bootloader gpmc settings

> Assuming it is, ideally we wouldn't merge such a patch, but I guess this 
> is somewhat complicated now with the DT transition.  So those should be 
> marked with comments so we know this is not a hardware bug... something 
> like the following.

Thanks

Regards
Afzal
