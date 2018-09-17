From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:51 -0400
Subject: [PATCH 13/13] iommu/mediatek: Switch to SPDX license identifier
In-Reply-To: <1535954502-30646-14-git-send-email-yong.wu@mediatek.com>
References: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
 <1535954502-30646-14-git-send-email-yong.wu@mediatek.com>
Message-ID: <5b9f3f54.1c69fb81.5265f.c120@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Sep 2018 14:01:42 +0800, Yong Wu wrote:
> Switch to SPDX license identifier for MediaTek iommu/smi and their
> header files.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c                     | 10 +---------
>  drivers/iommu/mtk_iommu.h                     | 10 +---------
>  drivers/iommu/mtk_iommu_v1.c                  | 10 +---------
>  drivers/memory/mtk-smi.c                      | 10 +---------
>  include/dt-bindings/memory/mt2701-larb-port.h | 10 +---------
>  include/dt-bindings/memory/mt8173-larb-port.h | 10 +---------
>  include/soc/mediatek/smi.h                    | 10 +---------
>  7 files changed, 7 insertions(+), 63 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
