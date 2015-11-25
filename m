From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 25 Nov 2015 09:30:54 +0800
Subject: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
In-Reply-To: <20151124103819.GE17658@ulmo.nvidia.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <20151014125620.GQ27420@8bytes.org> <1445488802.27202.67.camel@mhfsdcap03>
 <20151023092636.GX27420@8bytes.org> <1448344693.13079.6.camel@mhfsdcap03>
 <20151124103819.GE17658@ulmo.nvidia.com>
Message-ID: <1448415054.13079.9.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-11-24 at 11:38 +0100, Thierry Reding wrote:
> On Tue, Nov 24, 2015 at 01:58:13PM +0800, Yong Wu wrote:
> > On Fri, 2015-10-23 at 11:26 +0200, Joerg Roedel wrote:
> > > On Thu, Oct 22, 2015 at 12:40:02PM +0800, Yong Wu wrote:
> > > >      But the mtk-iommu depend on the drivers/memory/mtk-smi.c(mtk-iommu
> > > > has called a function of the mtk-smi).
> > > >      So if there is dependence here, How should we do to merge them?
> > > 
> > > I can surely merge mtk-smi too, if it gets proper Reviewed-by and
> > > Acked-by tags from the maintainer(s).
> > > 
> > > 
> > > 	Joerg
> > > 
> > Hi Joerg,
> > 
> >    About the driver/memory/, We don't know who is his maintainer.
> > MAINTAINERS file don't have drivers/memory maintainer.
> > From the history in drivers/memory/ it looks like most of the
> > drivers land with an ack from the architecture maintainer.
> > And Matthias Brugger is our "ARM/Mediatek SoC support" maintainer.
> > 
> > Then do you mean that we need Matthias's ACK or whom others?
> 
> Yes, I think the sub-architecture maintainer's ACK is probably going to
> be as good as it gets. Historically drivers/memory hasn't had enough of
> a common ground to instate a framework.
> 
> Thierry

Got it.
Thanks very much for your reply.

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
