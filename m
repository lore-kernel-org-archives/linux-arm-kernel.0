From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 23 May 2017 14:55:28 +0800
Subject: [PATCH] drm/mediatek: re-phrase DRM_INFO error message
In-Reply-To: <20170411134419.21277-1-colin.king@canonical.com>
References: <20170411134419.21277-1-colin.king@canonical.com>
Message-ID: <1495522528.20811.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Colin:

Sorry for my late reply. I've applied this patch to my branch
mediatek-drm-next-4.13, thanks.

Regards,
CK

On Tue, 2017-04-11 at 14:44 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current message contains a spelling mistake and is not easily
> parsable. Re-phrase it to be more understandable.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 808b995a990f..79d240ff1331 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -933,7 +933,7 @@ static u32 mtk_dsi_recv_cnt(u8 type, u8 *read_data)
>  		DRM_INFO("type is 0x02, try again\n");
>  		break;
>  	default:
> -		DRM_INFO("type(0x%x) cannot be non-recognite\n", type);
> +		DRM_INFO("type(0x%x) not recognized\n", type);
>  		break;
>  	}
>  
