From: joerg.roedel@amd.com (Joerg Roedel)
Date: Mon, 5 Dec 2011 16:47:15 +0100
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <20111205154715.GE25178@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 06:47:28PM +0900, KyongHo Cho wrote:
> Patch Summary:
> [PATCH v7 1/2] ARM: EXYNOS: Change System MMU platform device definitions
> [PATCH v7 2/2] iommu/exynos: Add iommu driver for Exynos Platforms

Okay, I merged it into arm/exynos, but it is not pushed yet. Actually
there were conflicts while merging, which I resolved. What I failed
to find is a config for Exynos that actually builds for upstream Linux.
Probably I havn't tried hard enough to find one... Can you provide a
kernel config that I can use for my testing and that builds a current
3.2-rc4 kernel for Exynos?

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
