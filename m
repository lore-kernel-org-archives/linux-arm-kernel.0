From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 11:39:51 +0200
Subject: [PATCH] iommu/mediatek: Do not call of_node_put in
 mtk_iommu_of_xlate
In-Reply-To: <1465379444-14719-1-git-send-email-honghui.zhang@mediatek.com>
References: <1465379444-14719-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20160621093951.GC28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 05:50:44PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The device_node will be released in of_iommu_configure, it may be double
> released if call of_node_put in mtk_iommu_of_xlate.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
