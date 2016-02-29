From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 29 Feb 2016 16:46:06 +0100
Subject: [PATCH] iommu/exynos: Use proper readl/writel register interface
In-Reply-To: <1456749777-8998-1-git-send-email-m.szyprowski@samsung.com>
References: <1456749777-8998-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160229154606.GB13711@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:42:57PM +0100, Marek Szyprowski wrote:
> Drivers should use generic readl/writel calls to access HW registers, so
> replace all __raw_readl/writel with generic version.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Applied, thanks.
