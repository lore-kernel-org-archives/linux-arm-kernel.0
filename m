From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 14:31:08 +0900
Subject: [PATCH v2 2/7] iommu/rockchip: add map_sg callback for
 rk_iommu_ops
In-Reply-To: <1465392392-2003-3-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-3-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5DNM518hk_RwF+af5Z881o9aEFSC237CvgfB8EAPM8s_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> From: Simon Xue <xxm@rock-chips.com>
>
> The iommu_dma_alloc() in iommu/dma-iommu.c calls iommu_map_sg()
> that requires the callback iommu_ops .map_sg(). Adding the
> default_iommu_map_sg() to rockchip iommu accordingly.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shunqian Zheng <xxm@rock-chips.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
