From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 10:17:06 +0100
Subject: [PATCH] iommu/mediatek: select IOMMU_IOVA
In-Reply-To: <1456737124-309812-1-git-send-email-arnd@arndb.de>
References: <1456737124-309812-1-git-send-email-arnd@arndb.de>
Message-ID: <2378616.7DbHXlMSLk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 10:11:58 Arnd Bergmann wrote:
> This adds the same select that the other drivers have. On a related
> note, I wonder if we should just always select ARM_DMA_USE_IOMMU
> whenever any IOMMU driver is enabled. Are there any cases where
> we would enable an IOMMU but not use it?

Subject line was wrong, I'll resend this with a second fix on top.

	Arnd
