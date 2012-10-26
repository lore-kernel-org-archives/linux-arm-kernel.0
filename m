From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Oct 2012 14:33:31 -0700
Subject: [PATCH v2] ARM: OMAP1: usb: fix sparse warnings
In-Reply-To: <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
 <20121026212059.GV11908@atomide.com>
 <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
Message-ID: <20121026213331.GX11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121026 14:30]:
> 
> Resolve the following sparse warnings:
> 
> arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
> arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
> arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?
> 
> by declaring those functions as static.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
> 
> Applies on linux-omap/omap-for-v3.8/cleanup-headers.

Thanks applied.

Regards,

Tony
