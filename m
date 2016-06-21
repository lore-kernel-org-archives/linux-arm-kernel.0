From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 14:54:35 +0200
Subject: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <20160621091732.GB28248@8bytes.org>
 <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
Message-ID: <20160621125435.GE11432@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Jun 21, 2016 at 09:42:16PM +0900, Tomasz Figa wrote:
> In simple words, DRM patches depend on IOMMU patches.
> 
> More precisely: The IOMMU patches alone are supposed to not break
> anything. Same goes for the first DRM patch (7/8). Only second DRM
> patch (8/8) depends on changes introduced by its predecessors.

The first DRM patch is 6/7, so it is 7/8 with the iommu dependency,
right? Anyway, I think the best is I take the iommu patches when Heiko
is ok with them and then the DRM tree can merge that branch in to apply
the DRM patches.

But first Heiko should have a look at the patches.


Thanks,

	Joerg
