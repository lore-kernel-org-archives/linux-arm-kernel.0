From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Nov 2014 20:28:35 +0100
Subject: [PATCH 2/2] ARM: berlin: do not select RESET_CONTROLLER
In-Reply-To: <1416231192-27056-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
 <1416231192-27056-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <546B9DE3.705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2014 14:33, Antoine Tenart wrote:
> RESET_CONTROLLER is meant to be user-selectable. To respect that,
> do not select it automatically when using ARCH_BERLIN.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied to berlin/soc.

Thanks!

> ---
>   arch/arm/mach-berlin/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index 5803f773a065..51582c73a53f 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -7,7 +7,6 @@ menuconfig ARCH_BERLIN
>   	select DW_APB_ICTL
>   	select DW_APB_TIMER_OF
>   	select PINCTRL
> -	select RESET_CONTROLLER
>
>   if ARCH_BERLIN
>
>
