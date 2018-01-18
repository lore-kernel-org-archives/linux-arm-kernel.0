From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 18 Jan 2018 13:44:03 +0100
Subject: [PATCH v4 00/13] iommu/rockchip: Use OF_IOMMU
In-Reply-To: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Message-ID: <20180118124403.GX28161@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 07:52:38PM +0800, Jeffy Chen wrote:
> Jeffy Chen (9):
>   iommu/rockchip: Prohibit unbind and remove
>   iommu/rockchip: Fix error handling in probe
>   iommu/rockchip: Request irqs in rk_iommu_probe()
>   ARM: dts: rockchip: add clocks in vop iommu nodes
>   iommu/rockchip: Use IOMMU device for dma mapping operations
>   iommu/rockchip: Use OF_IOMMU to attach devices automatically
>   iommu/rockchip: Fix error handling in init
>   iommu/rockchip: Add runtime PM support
>   iommu/rockchip: Support sharing IOMMU between masters
> 
> Tomasz Figa (4):
>   iommu/rockchip: Fix error handling in attach
>   iommu/rockchip: Use iopoll helpers to wait for hardware
>   iommu/rockchip: Fix TLB flush of secondary IOMMUs
>   iommu/rockchip: Control clocks needed to access the IOMMU

Please stop resending this every day with minimal changes. I am not
going to take it for v4.16, as we are late in the cycle already and there
are still review comments.

Just collect all feedback, update the patches, rebase them to v4.16-rc1
when its out, and send a new version.


	Joerg
