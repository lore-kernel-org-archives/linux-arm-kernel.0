From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 12:30:10 +0100
Subject: [PATCH] iommu/dma: Fix NEED_SG_DMA_LENGTH dependency
In-Reply-To: <189f8d7a6b1598108dc8e9f1777c67b07a4bd781.1456744313.git.robin.murphy@arm.com>
References: <189f8d7a6b1598108dc8e9f1777c67b07a4bd781.1456744313.git.robin.murphy@arm.com>
Message-ID: <2911570.ZzkiTVbXTY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 11:13:39 Robin Murphy wrote:
> IOMMU_DMA does indeed depend on scatterlists having a DMA length, but
> the NEED_SG_DMA_LENGTH symbol should be selected, not depended upon.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
