From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 13 Sep 2016 17:41:03 +0800
Subject: [PATCH v8 4/9] drm/mediatek: update display module connections
In-Reply-To: <1473681672-47144-5-git-send-email-yt.shen@mediatek.com>
References: <1473681672-47144-1-git-send-email-yt.shen@mediatek.com>
 <1473681672-47144-5-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473759663.28437.45.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Mon, 2016-09-12 at 20:01 +0800, YT Shen wrote:
> update connections for OVL, RDMA, BLS, DSI
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---

[snip...]

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 53065c7..0850aa4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -40,6 +40,7 @@ enum mtk_ddp_comp_type {
>  
>  enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_AAL,
> +	DDP_COMPONENT_BLS,

I think this should be moved to an independent patch and title of it
should be "Add BLS component." If you keep it in this patch, title of
this patch should be modified as "Add BLS component and update display
module connections."

Regards,
CK

>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
>  	DDP_COMPONENT_DPI0,
