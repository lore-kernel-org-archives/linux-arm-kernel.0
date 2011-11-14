From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Nov 2011 13:02:37 -0800
Subject: [RFC 5/5] iommu/omap: eliminate the public
 omap_find_iommu_device() method
In-Reply-To: <201111091017.41947.laurent.pinchart@ideasonboard.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <201109271346.13791.laurent.pinchart@ideasonboard.com>
 <CAK=WgbZaZTT=PsrvY8QTypuViknCK=APHogZLg5SjSN3_C=odw@mail.gmail.com>
 <201111091017.41947.laurent.pinchart@ideasonboard.com>
Message-ID: <20111114210236.GO31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [111109 00:42]:
> Hi Ohad,
> 
> On Wednesday 09 November 2011 09:50:30 Ohad Ben-Cohen wrote:
> > On Tue, Sep 27, 2011 at 2:46 PM, Laurent Pinchart wrote:
> > > On Sunday 25 September 2011 12:58:57 Ohad Ben-Cohen wrote:
> > >> Eliminate the public omap_find_iommu_device() method, and don't
> > >> expect clients to provide the omap_iommu handle anymore.
> > >> 
> > >> Instead, OMAP's iommu driver should now utilize dev_archdata's private
> > >> iommu extension to be able to access the required iommu information.
> > >> 
> > >> Update omap3isp appropriately.
> > >> 
> > >> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> > >> Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > >> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >> Cc: Tony Lindgren <tony@atomide.com>
> > > 
> > > For the OMAP3 ISP driver,
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Thanks !
> > 
> > Can you please also ack the 4th patch in this series (that's the part
> > the makes this fifth patch possible):
> > 
> > https://lkml.org/lkml/2011/9/25/46
> 
> Sure. Done.
> 
> > I could then ask Tony to Ack it so we could merge this via the iommu tree.

This too:

Acked-by: Tony Lindgren <tony@atomide.com>
