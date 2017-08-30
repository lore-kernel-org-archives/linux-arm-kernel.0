From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 30 Aug 2017 15:21:47 +0200
Subject: [PATCH 3/3] iommu: s390: constify iommu_ops
In-Reply-To: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170830132147.jog4r6barsx6rfvs@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 05:42:50PM +0530, Arvind Yadav wrote:
> iommu_ops are not supposed to change at runtime.
> Functions 'bus_set_iommu' working with const iommu_ops provided
> by <linux/iommu.h>. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
