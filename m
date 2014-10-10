From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 12:59:45 -0500
Subject: [PATCH 04/12] rtc: omap: remove unused register-base define
In-Reply-To: <1412881594-25678-5-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-5-git-send-email-johan@kernel.org>
Message-ID: <20141010175938.GP31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 09:06:26PM +0200, Johan Hovold wrote:
> Remove register-base define, which is no longer used.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/rtc/rtc-omap.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 2eca141e784e..d1b5562a148b 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -41,8 +41,6 @@
>  
>  #define	DRIVER_NAME			"omap_rtc"
>  
> -#define OMAP_RTC_BASE			0xfffb4800
> -
>  /* RTC registers */
>  #define OMAP_RTC_SECONDS_REG		0x00
>  #define OMAP_RTC_MINUTES_REG		0x04
> -- 
> 2.0.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/250cc496/attachment.sig>
