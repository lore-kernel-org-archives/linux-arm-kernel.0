From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Sep 2012 07:55:00 -0700
Subject: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to
 platform_data/dma-omap
In-Reply-To: <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
Message-ID: <20120928145459.GZ4840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
> Move plat/dma.h header to platform_data/dma-omap.h as
> part of the single zImage work.

Hmm there's no platform data in this header, just
exported things for drivers to use. So it should not
be placed into platform_data.

Maybe it should be #include <asm/mach/dma-omap.h> for now?

Regards,

Tony
