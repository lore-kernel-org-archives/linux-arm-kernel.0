From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Sep 2014 14:51:19 +0100
Subject: [PATCH] iommu: Make of_device_id array const
In-Reply-To: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
References: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
Message-ID: <20140911135119.GH6158@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 02:37:36PM +0100, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const.
> 
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/iommu/arm-smmu.c   |    2 +-
>  drivers/iommu/omap-iommu.c |    2 +-
>  drivers/iommu/tegra-gart.c |    2 +-
>  drivers/iommu/tegra-smmu.c |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Ha, I've seen a few of these patches recently. Did some tool just get
support for detecting this?

Anyway, looks fine and should probably go via Joerg.

Will
