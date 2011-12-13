From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 16:27:41 -0800
Subject: [PATCHv11 3/8] ARM: OMAP: prm: add support for chain interrupt
 handler
In-Reply-To: <1323713733-13115-4-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-4-git-send-email-t-kristo@ti.com>
Message-ID: <20111213002741.GP32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [111212 09:44]:
> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
> 
> PRCM interrupts have two priority levels, high or normal. High priority
> is needed for IO event handling, so that we can be sure that IO events
> are processed before other events. This reduces latency for IO event
> customers and also prevents incorrect ack sequence on OMAP3.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>

Assuming Paul will queue these:

Acked-by: Tony Lindgren <tony@atomide.com>
