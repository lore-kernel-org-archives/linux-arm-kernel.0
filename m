From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Sep 2016 12:47:16 +0200
Subject: [PATCH/RFT v2 0/8] Add SDHI to r8a7796/salvator-x
In-Reply-To: <20160906074901.GE17888@verge.net.au>
References: <1471938590-10650-1-git-send-email-horms+renesas@verge.net.au>
 <2032317.SOiUovHhFZ@avalon> <20160906074901.GE17888@verge.net.au>
Message-ID: <20160906104715.GE16304@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:49:02AM +0200, Simon Horman wrote:
> On Tue, Sep 06, 2016 at 03:34:41AM +0300, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Thank you for the patches.
> > 
> > On Tuesday 23 Aug 2016 09:49:42 Simon Horman wrote:
> > > Hi,
> > > 
> > > this patch set updates drivers, documentation and DT to
> > > enable SDHI0 & 3 on the r8a7796/salvator-x. This includes
> > > defining nodes for all available SDHI and GPIO devices.
> > > 
> > > I have boot-tested this which seems successful.
> > > However, I do not have physical access to an r8a7796/salvator-x board
> > > and the one that I have remote access to does not appear to have
> > > any SD cards present. I would be grateful of any testing anyone
> > > can provide.
> > > 
> > > Based on renesas-drivers-2016-08-09-v4.8-rc1
> > 
> > For patches 1/8, 4/8 and 6/8, applied on top of your devel branch (with the 
> > gpio-ranges property removed from 6/8 due to the lack of PFC support),
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks.

I have queued up 6/8 and 7/8 in a branch based on
sh-pfc-for-v4.9-tag2.
