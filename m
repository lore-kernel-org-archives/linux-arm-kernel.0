From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 10:33:24 +0200
Subject: [PATCH v7 03/25] iommu: Init iommu-groups support earlier, in
 core_initcall
In-Reply-To: <2209337.hhg3lyvUbi@avalon>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
 <1432041645-11172-4-git-send-email-m.szyprowski@samsung.com>
 <2209337.hhg3lyvUbi@avalon>
Message-ID: <20150529083323.GD13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 23, 2015 at 07:23:34PM +0300, Laurent Pinchart wrote:
> On Tuesday 19 May 2015 15:20:23 Marek Szyprowski wrote:
> > -arch_initcall(iommu_init);
> > +core_initcall(iommu_init);
> 
> I'll let Joerg comment on this, but this initcall ordering dance always makes 
> me feel that something isn't quite right. Have you had a chance to look at the 
> patch series I posted about a week ago to implement IOMMU probe deferral 
> support ?

Yeah, this is hacky, but I can live with it until your probe deferal
patch-set is merged.


	Joerg
