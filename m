From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 29 Mar 2018 12:24:22 +0200
Subject: [PATCH v8 00/14] iommu/rockchip: Use OF_IOMMU
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
Message-ID: <20180329102422.GG11365@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 03:38:00PM +0800, Jeffy Chen wrote:
> 
> This series fixes some issues in rockchip iommu driver, and add of_iommu
> support in it.
> 
> Changes in v8:
> Rebase on newest for-next.
> Don't introduce the additional return.
> Rename startup()/shutdown() to enable()/disable().
> Do runtime PM suspend in .shutdown().
> Modify pm_runtime_get_if_in_use()/pm_runtime_put() as Tomasz suggested.

Applied, thanks.
