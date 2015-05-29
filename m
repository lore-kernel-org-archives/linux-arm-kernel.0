From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 29 May 2015 10:52:30 +0200
Subject: [PATCH v7 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150529085230.GE13130@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 03:20:20PM +0200, Marek Szyprowski wrote:
> Marek Szyprowski (25):
>   drm/exynos: iommu: detach from default dma-mapping domain on init
>   drm/exynos: fimd: ensure proper hw state in fimd_clear_channel()
>   iommu: Init iommu-groups support earlier, in core_initcall
>   iommu/exynos: Don't read version register on every tlb operation
>   iommu/exynos: Remove unused functions
>   iommu/exynos: Remove useless members from exynos_iommu_owner structure
>   iommu/exynos: Refactor function parameters to simplify code
>   iommu/exynos: Rename variables to reflect their purpose
>   iommu/exynos: Use struct exynos_iommu_domain in internal structures
>   iommu/exynos: Remove excessive includes and sort others alphabetically
>   iommu/exynos: Document internal structures
>   iommu/exynos: Add/remove callbacks should fail if no iommu is
>     available
>   iommu/exynos: Add support for binding more than one sysmmu to master
>     device
>   iommu/exynos: Add support for runtime_pm
>   iommu/exynos: Add system suspend/resume support
>   iommu/exynos: Init from dt-specific callback instead of initcall
>   iommu/exynos: Add callback for initializing devices from device tree
>   ARM: Exynos: pm_domains: register power domain driver from
>     core_initcall
>   ARM: dts: exynos4: add sysmmu nodes
>   ARM: dts: exynos3250: add sysmmu nodes
>   ARM: dts: exynos4415: add sysmmu nodes
>   ARM: dts: exynos5250: add sysmmu nodes
>   ARM: dts: exynos5420: add sysmmu nodes
>   ARM: DMA-mapping: add support for creating reserved mappings in iova
>     space
>   ARM: dts: exynos: add iommu reserved regions for bootloader's splash
>     screen

Applied patches 3-17 to arm/exynos, thanks.
