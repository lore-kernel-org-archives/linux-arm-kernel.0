From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 20:01:27 -0700
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <cover.1349450723.git.afzal@ti.com>
References: <cover.1349450723.git.afzal@ti.com>
Message-ID: <20121009030126.GB12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [121005 09:02]:
> 
> Proposed generic routine has been tested on OneNAND (async) on
> OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
> local patch were used to test). For other cases of custom timing
> calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
> calculation routine was verified by simulating on OMAP3EVM.

Have you tested to make sure this works if you change the
L3 frequency?

That should probably be tested as a sanity check. Maybe you
can force the L3 for some test boots for this, I don't think
we scale it by default.

Regards,

Tony
