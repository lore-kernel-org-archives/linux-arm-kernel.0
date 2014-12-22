From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 22 Dec 2014 19:16:54 +0200
Subject: [PATCH 3.19-rc1 v14 1/8] arm: cnx3xxx: Remove spurious default
 for DEBUG_CNS3xxx
In-Reply-To: <1419267572-23981-1-git-send-email-daniel.thompson@linaro.org>
References: <1419267445-8330-1-git-send-email-daniel.thompson@linaro.org>
 <1419267572-23981-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20141222171654.GB6400@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, Dec 22, 2014 at 04:59:32PM +0000, Daniel Thompson wrote:
> The default value for DEBUG_CNS3XXX appears twice. This patch removes
> the one with the wrong sort order.

In Subject s/cnx3xxx/cns3xxx/

baruch

> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 5ddd4906f7a7..c5648cc1466d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1269,7 +1269,6 @@ config DEBUG_UART_PHYS
>  				DEBUG_S3C2410_UART2)
>  	default 0x78000000 if DEBUG_CNS3XXX
>  	default 0x7c0003f8 if FOOTBRIDGE
> -	default 0x78000000 if DEBUG_CNS3XXX
>  	default 0x80010000 if DEBUG_ASM9260_UART
>  	default 0x80070000 if DEBUG_IMX23_UART
>  	default 0x80074000 if DEBUG_IMX28_UART

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
