From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 May 2012 09:06:09 -0700
Subject: [PATCH 4/4] USB: Remove omap2 support from omap_udc.c
In-Reply-To: <20120522070914.GD30559@arwen.pp.htv.fi>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190111.927.38546.stgit@muffinssi.local>
 <20120522070914.GD30559@arwen.pp.htv.fi>
Message-ID: <20120522160608.GB16308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120522 00:15]:
> On Mon, May 21, 2012 at 12:01:11PM -0700, Tony Lindgren wrote:
> > There are no active users of this code for omap2 as
> > the boards in use have either TUSB or MUSB controller.
> > 
> > While at it, also fix warnings related to uninitialized
> > dc_clk and hhc_clk.
> > 
> > Cc: linux-usb at vger.kernel.org
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This one doesn't depend on the rest of the series, I can take it myself
> to v3.6 or you can take it with your series:

Yes you can take this one.

Thanks,

Tony
