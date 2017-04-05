From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 5 Apr 2017 19:09:59 +0800
Subject: [PATCH] media: mtk-vcodec: remove informative log
In-Reply-To: <1491389669-32737-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1491389669-32737-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1491390599.32502.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-05 at 18:54 +0800, Minghsiu Tsai wrote:
> Driver is stable. Remove DEBUG definition from driver.
> 
> There are debug message in /var/log/messages if DEBUG is defined,
> such as:
> [MTK_V4L2] level=0 fops_vcodec_open(),170: decoder capability 0
> [MTK_V4L2] level=0 fops_vcodec_open(),177: 16000000.vcodec decoder [0]
> [MTK_V4L2] level=0 fops_vcodec_release(),200: [0] decoder
> 
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Acked-by:Tiffany Lin <Tiffany.lin@mediatek.com>

> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
> index 7d55975..1248083 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
> @@ -31,7 +31,6 @@ struct mtk_vcodec_mem {
>  extern int mtk_v4l2_dbg_level;
>  extern bool mtk_vcodec_dbg;
>  
> -#define DEBUG	1
>  
>  #if defined(DEBUG)
>  
