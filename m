From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Jun 2012 20:05:27 +0200
Subject: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
In-Reply-To: <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1397795.nxQGnEDtVe@avalon>
 <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
Message-ID: <1854687.1eeiLuW4oH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wednesday 27 June 2012 10:36:04 Paul Walmsley wrote:
> On Wed, 27 Jun 2012, Laurent Pinchart wrote:
> > I think you've missed drivers/media/video/omap3isp/isp.c. Should I send a
> > patch for that ? Do these changes depend on anything not yet in mainline
> > that I should apply to my tree for testing ?
> 
> What would be ideal is if omap3isp could be converted to runtime PM for its
> internal IP block control. Almost all of the other OMAP on-chip oC drivers
> have been converted. Please let us know if more information or assistance is
> needed with this.

How does that integrate with the clock framework ?

-- 
Regards,

Laurent Pinchart
