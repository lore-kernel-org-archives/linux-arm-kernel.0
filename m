From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 25 May 2018 12:23:58 +0800
Subject: [PATCH v3 4/8] drm/mediatek: add ddp component AAL1
In-Reply-To: <1527215665-11937-5-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
 <1527215665-11937-5-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527222238.27165.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh at mediatek.com wrote:
> From: Stu Hsieh <stu.hsieh@mediatek.com>
> 
> This patch add component AAL1 and
> rename AAL to AAL0
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 0828cf8bf85c..eee3c0cc2632 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -41,7 +41,8 @@ enum mtk_ddp_comp_type {
>  };
>  
>  enum mtk_ddp_comp_id {
> -	DDP_COMPONENT_AAL,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_AAL1,

Be sure compiling is success when you apply each patch of a series. I
think when you apply to this patch, it would cause compiling error
because some related modification is in the patch 'Add support for
mediatek SOC MT2712'. So move the modification from that patch to this
patch.

Regards,
CK

>  	DDP_COMPONENT_BLS,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_COLOR1,
