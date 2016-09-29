From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 29 Sep 2016 12:01:22 +0800
Subject: [PATCH] drm/mediatek: fix a typo
In-Reply-To: <1475119322-58657-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1475119322-58657-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1475121682.18843.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: CK Hu <ck.hu@mediatek.com>

On Thu, 2016-09-29 at 11:22 +0800, Bibby Hsieh wrote:
> Fix the typo: OD_RELAYMODE->OD_CFG
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index df33b3c..aa5f20f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -123,7 +123,7 @@ static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
>  			  unsigned int bpc)
>  {
>  	writel(w << 16 | h, comp->regs + DISP_OD_SIZE);
> -	writel(OD_RELAYMODE, comp->regs + OD_RELAYMODE);
> +	writel(OD_RELAYMODE, comp->regs + OD_CFG);
>  	mtk_dither_set(comp, bpc, DISP_OD_CFG);
>  }
>  
