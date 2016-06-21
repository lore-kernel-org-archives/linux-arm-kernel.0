From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 15:52:02 +0200
Subject: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <2015742.xhx642kbrC@diego>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
 <20160621125435.GE11432@8bytes.org> <2015742.xhx642kbrC@diego>
Message-ID: <20160621135202.GK28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 03:18:49PM +0200, Heiko St?bner wrote:
> Am Dienstag, 21. Juni 2016, 14:54:35 schrieb Joerg Roedel:
> > Hi Tomasz,
> > 
> > On Tue, Jun 21, 2016 at 09:42:16PM +0900, Tomasz Figa wrote:
> > > In simple words, DRM patches depend on IOMMU patches.
> > > 
> > > More precisely: The IOMMU patches alone are supposed to not break
> > > anything. Same goes for the first DRM patch (7/8). Only second DRM
> > > patch (8/8) depends on changes introduced by its predecessors.
> > 
> > The first DRM patch is 6/7, so it is 7/8 with the iommu dependency,
> > right? Anyway, I think the best is I take the iommu patches when Heiko
> > is ok with them and then the DRM tree can merge that branch in to apply
> > the DRM patches.
> > 
> > But first Heiko should have a look at the patches.
> 
> I think from all his previous work on the rockchip iommus Tomasz is a lot more 
> qualified to judge them - which I guess he did when picking up the ones from 
> Rockchip devs :-) .

In that case you guys should probably co-maintain that driver?
> 
> >From a style-side, please don't carry the Reviewed-on gerrit tags over to 
> mainline patches (patches 1 and 2).

Okay.



	Joerg
