From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 12:25:41 +0100
Subject: [PATCH] iommu: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1bwo8o-0005LV-54@rmk-PC.armlinux.org.uk>
References: <E1bwo8o-0005LV-54@rmk-PC.armlinux.org.uk>
Message-ID: <20161110112541.GB9996@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 11:30:34AM +0100, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/iommu/mtk_iommu.c    | 8 +++++---
>  drivers/iommu/mtk_iommu.h    | 5 +++++
>  drivers/iommu/mtk_iommu_v1.c | 8 +++++---
>  3 files changed, 15 insertions(+), 6 deletions(-)

Applied, thanks.
