From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:48:53 -0800
Subject: [PATCH 11/16] ARM: omap: fix section mismatch error for
 omap_4430sdp_display_init()
In-Reply-To: <E1RvAYM-0006HW-IG@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAYM-0006HW-IG@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208184852.GK29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:08]:
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xb798): Section mismatch in reference from the function omap_4430sdp_display_init() to the function .init.text:omap_display_init()
> The function omap_4430sdp_display_init() references
> the function __init omap_display_init().
> This is often because omap_4430sdp_display_init lacks a __init
> annotation or the annotation of omap_display_init is wrong.
> 
> Fix this by adding __init to omap_4430sdp_display_init().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
