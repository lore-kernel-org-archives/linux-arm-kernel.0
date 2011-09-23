From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 23 Sep 2011 17:47:44 -0600
Subject: [PATCH 08/11] OMAP2+: board-generic: Add i2c static init
In-Reply-To: <20110923231208.GE6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
	<1316809399-19579-9-git-send-email-b-cousson@ti.com>
	<20110923231208.GE6324@atomide.com>
Message-ID: <20110923234744.GL24631@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 04:12:08PM -0700, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> > Still needed to boot until the i2c & twl driver is adapted to
> > device-tree. Otherwise the voltage control code will try to
> > access the twl and crash.
> 
> That sounds OK to me for now. For merging these patches, how
> about the following:
> 
> - Kevin queues up the omap_device related changes
> 
> - Grant queues up the .dts changes
> 
> - I'll queue the map_io and board changes based on Kevin's
>   omap_device changes

Go ahead and queue up the .dts changes in your tree.  No need to split them up.

g.
