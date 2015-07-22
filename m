From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 22 Jul 2015 16:38:52 +0530
Subject: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
In-Reply-To: <20150721150306.GI31095@arm.com>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-2-git-send-email-sricharan@codeaurora.org>
 <20150721150306.GI31095@arm.com>
Message-ID: <000501d0c46e$ceae9920$6c0bcb60$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Tuesday, July 21, 2015 8:33 PM
> To: Sricharan R
> Cc: linux-arm-kernel at lists.infradead.org;
iommu at lists.linux-foundation.org;
> devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> mitchelh at codeaurora.org; robin.murphy at arm.com
> Subject: Re: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using
> IOMMU_OF_DECLARE
> 
> [adding Robin]
> 
> On Fri, Jul 17, 2015 at 05:53:22PM +0100, Sricharan R wrote:
> > This patch uses IOMMU_OF_DECLARE to register the driver and the
> > iommu_ops. So when master devices of the iommu are registered,
> > of_xlate callback can be used to add the master configurations to the
> > smmu driver.
> 
> I'd really prefer to do this on top of Laurent's series reworking some of
the
> of_xlate code and I think Robin [CC'd] is working on that. That will also
pave
> the way for specifying per-master SMR configuration in the device-tree.

     Ok, understand it. By Rebasing on Laurent's series this patch should
not
     be needed at all, dependencies with clock devices should also be
solved.
     I will rebase this series over there.

Regards,
 Sricharan
