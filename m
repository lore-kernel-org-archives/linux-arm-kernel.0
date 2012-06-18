From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 Jun 2012 10:23:03 -0600 (MDT)
Subject: [PATCH v2 2/4] ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk()
 API
In-Reply-To: <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
 <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <alpine.DEB.2.00.1206181022370.11642@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 20 Apr 2012, Tarun Kanti DebBarma wrote:

> Add an API to get main clock name associated with a given @oh.
> This will avoid the need to construct fclk names during early
> initialization in order to get fclk handle using clk_get().
> 
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Thanks, queued for 3.6 with Beno?t's ack.


- Paul
