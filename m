From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 27 Jan 2016 09:16:26 +0800
Subject: [PATCH v3 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
 support
In-Reply-To: <066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
 <066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
Message-ID: <1453857386.28284.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-26 at 17:13 +0000, Robin Murphy wrote:
> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> only a few legacy and CPU-centric aspects which shouldn't be necessary
> for IOMMU API use anyway.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This looks good to me.
And actually our disp/vdec/venc works well on your v2.

You could choose the two below,
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Tested-by: Yong Wu <yong.wu@mediatek.com>

Thanks.

> ---
>  drivers/iommu/Kconfig              |  19 +
>  drivers/iommu/Makefile             |   1 +
>  drivers/iommu/io-pgtable-arm-v7s.c | 849 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c         |   3 +
>  drivers/iommu/io-pgtable.h         |  14 +-
>  5 files changed, 885 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c
