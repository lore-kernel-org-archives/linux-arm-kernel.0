From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 13:45:33 +0100
Subject: [PATCH] iommu/exynos: Use proper readl/writel register interface
In-Reply-To: <1456749777-8998-1-git-send-email-m.szyprowski@samsung.com>
References: <1456749777-8998-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <29479753.zv5GYuOXNm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 13:42:57 Marek Szyprowski wrote:
> Drivers should use generic readl/writel calls to access HW registers, so
> replace all __raw_readl/writel with generic version.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
