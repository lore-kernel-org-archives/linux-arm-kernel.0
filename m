From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 29 Feb 2016 17:28:46 +0100
Subject: [PATCH] iommu/dma: Fix NEED_SG_DMA_LENGTH dependency
In-Reply-To: <189f8d7a6b1598108dc8e9f1777c67b07a4bd781.1456744313.git.robin.murphy@arm.com>
References: <189f8d7a6b1598108dc8e9f1777c67b07a4bd781.1456744313.git.robin.murphy@arm.com>
Message-ID: <20160229162846.GD13711@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 11:13:39AM +0000, Robin Murphy wrote:
> IOMMU_DMA does indeed depend on scatterlists having a DMA length, but
> the NEED_SG_DMA_LENGTH symbol should be selected, not depended upon.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
