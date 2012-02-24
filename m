From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Feb 2012 14:45:56 +0100
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
Message-ID: <014601ccf2fa$a25c8560$e7159020$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday, December 29, 2011 1:24 PM KyongHo Cho wrote:

> Changes since v7:
> - Rebased with the recent commits of the following git branches
>   * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
>   * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git/for-next
> - Changed magic numbers into macros
> - Setting owner of a System MMU in 'iommu' field of dev_archdata
> - Verbose message in the default fault handler
> - Some bug fixes.

(snipped)

The time is flying away and v3.4 merge windows will open soon. Do you plan to
send an updated version of the SYSMMU driver anytime soon? It will be really 
nice to have it finally merged to v3.4.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
