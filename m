From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 20 Mar 2018 13:57:17 -0500
Subject: [PATCH] iommu/mediatek: Fix protect memory setting
In-Reply-To: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
References: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 09:52:54AM +0800, Yong Wu wrote:
> To avoid adding this complex macro or a new function, I put
> it in the code and backup its value in the suspend registers.

Missing Signed-off-by.

> ---
>  drivers/iommu/mtk_iommu.c | 15 ++++++++++-----
>  drivers/iommu/mtk_iommu.h |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)


Joerg
