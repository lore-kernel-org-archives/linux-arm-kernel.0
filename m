From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 11:07:18 +0900
Subject: [PATCH 0/1] gpio-rcar: Add DT support
In-Reply-To: <2295525.muus9MNBiz@avalon>
References: <1371106826-25313-1-git-send-email-horms+renesas@verge.net.au>
 <1371106826-25313-2-git-send-email-horms+renesas@verge.net.au>
 <20130615004751.GM18124@quad.lixom.net> <2295525.muus9MNBiz@avalon>
Message-ID: <20130617020717.GH15043@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 01:31:08PM +0200, Laurent Pinchart wrote:
> Hi Olof,
> 
> On Friday 14 June 2013 17:47:51 Olof Johansson wrote:
> > On Thu, Jun 13, 2013 at 04:00:26PM +0900, Simon Horman wrote:
> > > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Add DT bindings for the gpio-rcar driver and read the device
> > > configuration from the DT node at probe time if available.
> > > 
> > > Cc: devicetree-discuss at lists.ozlabs.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Hi,
> > 
> > I don't see this cc/acked by Linus or Grant/Rob.
> 
> The patch has been acked by Linus, but it seems the ack got lost somewhere.
> 
> https://patchwork.kernel.org/patch/2596901/

Sorry for missing that.

> > However, the binding looks very vanilla to me, so I'll merge it anyway.
> 
> Thank you.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
