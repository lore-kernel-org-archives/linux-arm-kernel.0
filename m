From: gxt@mprc.pku.edu.cn (Guan Xuetao)
Date: Thu, 02 Jun 2011 17:49:17 +0800
Subject: [PATCH] Fix build warning of the defconfigs
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <1307008157.1652.4.camel@epip-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  arch/arm/configs/davinci_all_defconfig     |    2 +-
>  arch/arm/configs/mxs_defconfig             |    2 +-
>  arch/arm/configs/netx_defconfig            |    2 +-
>  arch/arm/configs/viper_defconfig           |    2 +-
>  arch/arm/configs/xcep_defconfig            |    2 +-
>  arch/arm/configs/zeus_defconfig            |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-
>  arch/mips/configs/mtx1_defconfig           |    2 +-
>  arch/powerpc/configs/52xx/pcm030_defconfig |    2 +-
>  arch/powerpc/configs/ps3_defconfig         |    2 +-
>  arch/sh/configs/titan_defconfig            |    2 +-
>  arch/unicore32/configs/debug_defconfig     |    2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/unicore32/configs/debug_defconfig b/arch/unicore32/configs/debug_defconfig
> index b5fbde9..1c367f0 100644
> --- a/arch/unicore32/configs/debug_defconfig
> +++ b/arch/unicore32/configs/debug_defconfig
> @@ -168,7 +168,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  
>  #	Real Time Clock
>  CONFIG_RTC_LIB=m
> -CONFIG_RTC_CLASS=m
> +CONFIG_RTC_CLASS=y
>  
>  ### File systems
>  CONFIG_EXT2_FS=m

I adjust this config option recently, and enable it with y.
So please just drop the modification in unicore32 config file.

Thanks & Regards.

Guan Xuetao
