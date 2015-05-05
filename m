From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 May 2015 18:18:02 +0200
Subject: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
In-Reply-To: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150505161802.GA20611@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 03:41:21PM +0800, Yong Wu wrote:
> This patch is for ARM Short Descriptor Format.It has 2-levels
> pagetable and the allocator supports 4K/64K/1M/16M.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/io-pgtable-arm-short.c | 489 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c           |   4 +
>  drivers/iommu/io-pgtable.h           |   6 +
>  5 files changed, 507 insertions(+)
>  create mode 100644 drivers/iommu/io-pgtable-arm-short.c

What is the context of this, where will it be used?


	Joerg
