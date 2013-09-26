From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 26 Sep 2013 15:34:08 +0300
Subject: [PATCH] video: mxsfb: Add missing break
In-Reply-To: <1380194038-5148-1-git-send-email-marex@denx.de>
References: <1380194038-5148-1-git-send-email-marex@denx.de>
Message-ID: <524429C0.2020907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/13 14:13, Marek Vasut wrote:
> Add missing break into the restore function.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/mxsfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index d250ed0..27197a8 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -620,6 +620,7 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
>  		break;
>  	case 3:
>  		bits_per_pixel = 32;
> +		break;
>  	case 1:
>  	default:
>  		return -EINVAL;
> 

Thanks, queued for 3.12 fixes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/d3beecaa/attachment-0001.sig>
