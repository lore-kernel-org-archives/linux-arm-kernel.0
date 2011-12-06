From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 6 Dec 2011 17:23:46 +0100
Subject: [PATCH v7 0/2] iommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20111205154715.GE25178@amd.com>
References: <1321609650-1329-1-git-send-email-pullip.cho@samsung.com>
 <20111205154715.GE25178@amd.com>
Message-ID: <20111206162346.GP25178@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 04:47:15PM +0100, Joerg Roedel wrote:

> Okay, I merged it into arm/exynos, but it is not pushed yet. Actually
> there were conflicts while merging, which I resolved. What I failed
> to find is a config for Exynos that actually builds for upstream Linux.
> Probably I havn't tried hard enough to find one... Can you provide a
> kernel config that I can use for my testing and that builds a current
> 3.2-rc4 kernel for Exynos?

Okay, since there are new objections and since I can't even reliably
build test the driver I unmerged it again.
Please fix the outstanding issues and rebase it against a recent upstream
kernel so that the result can be compiled to a kernel-image.


Thanks,

	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
