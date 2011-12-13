From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 16:25:56 -0800
Subject: [PATCHv11 8/8] ARM: OMAP: mux: add support for selecting
 mpu_irq for each wakeup pad
In-Reply-To: <1323713733-13115-9-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-9-git-send-email-t-kristo@ti.com>
Message-ID: <20111213002555.GO32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [111212 09:44]:
> By default all registered pads will trigger mpu_irqs[0]. Now there is
> an API for selecting used mpu_irq on pad basis, which can be used to
> trigger different irq handlers for different pads in the same hwmod.
> Each pad that requires its interrupt to be re-routed this way must
> have a separate call to omap_hwmod_pad_route_irq(hwmod, pad, irq).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
