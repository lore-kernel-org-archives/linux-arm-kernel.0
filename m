From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 28 May 2018 15:09:51 +0800
Subject: [PATCH v4 6/9] drm/mediatek: add ddp component PWM2
In-Reply-To: <1527489507-24453-7-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
 <1527489507-24453-7-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527491391.24367.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch add component PWM2
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index a5c7ac2d162d..86e8c9e5df41 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -233,6 +233,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
>  	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
> +	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
>  	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
>  	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
>  	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 9b19fc4423f1..e00c2e798abd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -56,6 +56,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_PWM0,
>  	DDP_COMPONENT_PWM1,
> +	DDP_COMPONENT_PWM2,
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_RDMA1,
>  	DDP_COMPONENT_RDMA2,
