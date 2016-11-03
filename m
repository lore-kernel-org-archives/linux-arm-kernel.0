From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 Nov 2016 21:37:11 +0100
Subject: [PATCH] iommu/arm-smmu: Check that iommu_fwspecs are ours
In-Reply-To: <b3680f58498efd0914c5d7887737a7ef9b733982.1478107892.git.robin.murphy@arm.com>
References: <b3680f58498efd0914c5d7887737a7ef9b733982.1478107892.git.robin.murphy@arm.com>
Message-ID: <20161103203711.GW3541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 05:31:32PM +0000, Robin Murphy wrote:
> We seem to have forgotten to check that iommu_fwspecs actually belong to
> us before we go ahead and dereference their private data. Oops.
> 
> Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)a

Applied to iommu/fixes, thanks.
