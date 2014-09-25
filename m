From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 25 Sep 2014 16:01:20 +0200
Subject: [PATCH] iommu: Make of_device_id array const
In-Reply-To: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
References: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
Message-ID: <20140925140120.GA8306@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 07:07:36PM +0530, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const.
> 
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/iommu/arm-smmu.c   |    2 +-
>  drivers/iommu/omap-iommu.c |    2 +-
>  drivers/iommu/tegra-gart.c |    2 +-
>  drivers/iommu/tegra-smmu.c |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.
