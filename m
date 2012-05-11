From: joerg.roedel@amd.com (Joerg Roedel)
Date: Fri, 11 May 2012 14:43:27 +0200
Subject: [PATCH] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <000001cd2f71$62c5c2f0$285148d0$%cho@samsung.com>
References: <000001cd2f71$62c5c2f0$285148d0$%cho@samsung.com>
Message-ID: <20120511124327.GB11750@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 09:27:09PM +0900, KyongHo wrote:
> This is the System MMU driver and IOMMU API implementation for Exynos SOC
> platforms. Exynos platforms has more than 10 System MMUs dedicated for each
> multimedia accelerators.
> 
> The System MMU driver is already in arc/arm/plat-s5p but it is moved to
> drivers/iommu due to Ohad Ben-Cohen gathered IOMMU drivers there
> 
> Any device driver in Exynos platforms that needs to control its System MMU must
> call platform_set_sysmmu() to inform System MMU driver who will control it.
> platform_set_sysmmu() is defined in <mach/sysmmu.h>
> 
> To compile this patch,
> you will need "for-next" branch of the linux-samsung.git:
> git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> Other patches needed by this patch are merged to the above branch.
> 
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>

Looks good.

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

Please get this merged via the Samsung tree. Since the patch depends on
that tree anyway it makes the most sense to be there.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
