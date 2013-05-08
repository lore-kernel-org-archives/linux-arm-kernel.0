From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 16:52:32 -0700
Subject: [PATCH] ARM: OMAP2+: omap-usb-host: clean up pin mux setup code
In-Reply-To: <1366624673-2684-1-git-send-email-rogerq@ti.com>
References: <1366624673-2684-1-git-send-email-rogerq@ti.com>
Message-ID: <20130508235232.GW32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130422 03:02]:
> The USB host pins are named quite differently between OMAP3 and
> OMAP4+ SoCs. To make this managable in code, we create a pin mapping
> table (pin_names) that maps pin function to pin name.
> 
> This pin mapping table is populated at runtime based on a pin
> name template. Templates are provided for OMAP3 and 4 SoCs.
> 
> The setup_io_mux() function uses the pin mapping table to
> setup the pin mux.
> 
> The resulting code is a lot more clean, manageable and scalable.

I'm planning to drop all the omap4 pdata soonish. Will post some
patches after -rc1 to do that. Do you still need this patch
considering that?

Regards,

Tony
