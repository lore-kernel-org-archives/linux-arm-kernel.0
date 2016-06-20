From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 20 Jun 2016 15:52:41 +0200
Subject: next-20160620 build: 2 failures 9 warnings (next-20160620)
In-Reply-To: <20160620134200.GU26099@sirena.org.uk>
References: <E1bEwGe-0004DR-4p@optimist> <20160620134200.GU26099@sirena.org.uk>
Message-ID: <20160620135241.GN29948@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 02:42:00PM +0100, Mark Brown wrote:
> On Mon, Jun 20, 2016 at 11:17:20AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build due to:
> 
> > 	arm64-allmodconfig
> > ../drivers/iommu/mtk_iommu.c:27:32: fatal error: linux/of_component.h: No such file or directory
> 
> which is triggered by da4d6e6d3b3ef (iommu/mediatek: Convert DT
> component matching to component_match_add_release()) - there is
> presumably a dependency on some other patch series that is still in
> review.

Yes, this came to my attention already. I will remove that patch from
the iommu tree.


Thanks,

	Joerg
