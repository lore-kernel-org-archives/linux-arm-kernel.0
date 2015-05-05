From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 May 2015 16:53:51 +0200
Subject: [PATCH v6 09/25] iommu: exynos: remove unused functions, part 2
In-Reply-To: <1430727380-10912-10-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150505145351.GK15736@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 10:16:04AM +0200, Marek Szyprowski wrote:
> After refactoring functions to use pointer to struct sysmmu_drvdata
> directly, some functions became useless and thus never used, so remove
> them completely.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 43 -------------------------------------------
>  1 file changed, 43 deletions(-)

Can you fold this patch into the previous one? Then the simplifications
become directly visible in the diffstat.
