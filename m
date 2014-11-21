From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 15:33:25 -0800
Subject: [PATCH v2 2/2] ARM: dts: Add devicetree for NovaTech OrionLXm
In-Reply-To: <20141117190847.GA4857@saruman>
References: <1416250957-11065-1-git-send-email-george.mccollister@gmail.com>
 <1416250957-11065-2-git-send-email-george.mccollister@gmail.com>
 <20141117190847.GA4857@saruman>
Message-ID: <20141121233325.GZ7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141117 11:10]:
> On Mon, Nov 17, 2014 at 01:02:35PM -0600, George McCollister wrote:
> > This adds the NovaTech OrionLXm which is based on the AM335x SoC
> > http://www.novatechweb.com/substation-automation/orionlxm/
> > 
> > RAM: 512MiB
> > Flash: 4GB eMMC
> > Ethernet PHYs: 2x Micrel KSZ8041FTLI
> > USB ports are used internally by the expansion cards.
> > Internal micro SD slot is available.
> > 
> > Signed-off-by: George McCollister <george.mccollister@gmail.com>
> 
> this looks might better to my eyes:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.19/dt-v2 thanks.

Tony
