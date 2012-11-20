From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 20 Nov 2012 16:37:22 +0900
Subject: [PATCH v2 0/12] iommu/exynos: Fixes and Enhancements of System MMU
 driver with DT
In-Reply-To: <001a01cdc6f0$d06c1f90$71445eb0$%cho@samsung.com>
References: <001a01cdc6f0$d06c1f90$71445eb0$%cho@samsung.com>
Message-ID: <CAHQjnOMke6661jE5YL8np=-PrU6rYCShxshom4DuA92BNGqOCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 4:29 PM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> Patch summary:
> [PATCH v2 01/12] ARM: EXYNOS: remove system mmu initialization from
arch/arm/ tree
> [PATCH v2 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System MMU
> [PATCH v2 03/12] ARM: EXYNOS: add System MMU definition to DT
> [PATCH v2 04/12] iommu/exynos: support for device tree
> [PATCH v2 05/12] iommu/exynos: pass version information from DT
> [PATCH v2 06/12] iommu/exynos: allocate lv2 page table from own slab
> [PATCH v2 07/12] iommu/exynos: change rwlock to spinlock
> [PATCH v2 08/12] iommu/exynos: set System MMU as the parent of client
device
> [PATCH v2 09/12] iommu/exynos: add supoort for runtime pm and
suspend/resume
> [PATCH v2 10/12] iommu/exynos: add support for System MMU 3.2 and 3.3
> [PATCH v2 11/12] iommu/exynos: add literal name of System MMU for
debugging
> [PATCH v2 12/12] iommu/exynos: add debugfs entries for System MMU
>

It is required to be merged from the patch 01/12 to 09/12 for correct
working with DT and power management.
Patch 10/12 is required to support new version of System MMU that is IOMMU
in Exynos cores.
Patch 11/12 and 12/12 is adding debugging features.

Thank you.

Cho KyongHo.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/db936eae/attachment-0001.html>
