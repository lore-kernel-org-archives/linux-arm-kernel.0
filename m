From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 22:04:59 +0900
Subject: [PATCH] ARM: shmobile: genmai: remove defconfig
In-Reply-To: <20140715122350.GD25333@verge.net.au>
References: <1405409364-23378-1-git-send-email-horms+renesas@verge.net.au>
 <3624228.NbiLenVez0@avalon> <20140715122350.GD25333@verge.net.au>
Message-ID: <20140715130458.GI25333@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 09:23:50PM +0900, Simon Horman wrote:
> On Tue, Jul 15, 2014 at 01:58:21PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Thank you for the patch.
> > 
> > On Tuesday 15 July 2014 16:29:24 Simon Horman wrote:
> > > The genmai board code is scheduled for removal and once
> > > that occurs the defconfig will be of no use. Remove it.
> > > 
> > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Now that the MTU2 boot issue has been solved (thank you for tracking it down), 
> > am I correct to assume that all timer patches, the genmai board file removal 
> > series and this patch will make it to v3.17 ?
> 
> Yes, that is my plan.
> 
> I hope to have them queued up this evening.

Please take a look at renesas-next-v3.16-rc3-20140715v2 and let
me know if anything is missing.
