From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 13:29:17 +0800
Subject: [PATCH 07/28] drm/mediatek: add component DPI1
In-Reply-To: <1528687580-549-8-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-8-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528867757.15127.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-11 at 11:25 +0800, Stu Hsieh wrote:
> This patch add the component DPI1
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 86e8c9e5df41..4f9d81025d69 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -224,6 +224,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
>  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
>  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> +	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index e00c2e798abd..54c99c169093 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -47,6 +47,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_DPI0,
> +	DDP_COMPONENT_DPI1,
>  	DDP_COMPONENT_DSI0,
>  	DDP_COMPONENT_DSI1,
>  	DDP_COMPONENT_GAMMA,
