From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 30 Aug 2017 15:14:24 +0200
Subject: [PATCH 1/3] iommu: exynos: constify iommu_ops
In-Reply-To: <1503922325-25905-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503922325-25905-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20170830131424.2psz2gtgzlghzp5i@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 05:42:05PM +0530, Arvind Yadav wrote:
> iommu_ops are not supposed to change at runtime.
> Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
> const iommu_ops provided by <linux/iommu.h>. So mark the non-const
> structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
