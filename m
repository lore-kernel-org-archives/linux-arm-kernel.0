From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 09:39:48 -0600 (MDT)
Subject: [PATCH v2 2/4] ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk()
 API
In-Reply-To: <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
 <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <alpine.DEB.2.00.1207040939380.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Apr 2012, Tarun Kanti DebBarma wrote:

> Add an API to get main clock name associated with a given @oh.
> This will avoid the need to construct fclk names during early
> initialization in order to get fclk handle using clk_get().

Thanks, queued.

- Paul
