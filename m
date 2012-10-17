From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Oct 2012 10:38:37 -0700
Subject: [PATCH] ARM: OMAP: move plat-omap/include/plat/sdrc.h into
 mach-omap2/sdrc.h
In-Reply-To: <alpine.DEB.2.00.1210170038200.9767@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210170038200.9767@utopia.booyaka.com>
Message-ID: <20121017173837.GU15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121016 17:48]:
> 
> Remove arch/arm/plat-omap/include/plat/sdrc.h by folding its contents
> into arch/arm/mach-omap2/sdrc.h.  The objective is to assist Tony in
> cleaning out arch/arm/plat-omap/, as his upstreams request.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> 
> This has a dependency on Tomi's "OMAP: VRFB: convert to platform device" 
> series.

Thanks applying this into omap-for-v3.8/cleanup-headers-dss.

Regards,

Tony
