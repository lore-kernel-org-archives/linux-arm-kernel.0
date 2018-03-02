From: joyce.ooi@intel.com (Ooi, Joyce)
Date: Fri, 2 Mar 2018 06:41:38 +0000
Subject: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
In-Reply-To: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
References: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C0450754EA0A@PGSMSX101.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's been a while since I received any feedback about this patch. Are there any concerns about this patch? If no, could you please kindly ACK this patch?

Thanks.

Regards,
Joyce Ooi

> -----Original Message-----
> From: Ooi, Joyce
> Sent: Thursday, February 15, 2018 11:20 AM
> To: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; Nguyen, Dinh <dinh.nguyen@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ooi,
> Joyce <joyce.ooi@intel.com>; Vandervennet, Yves
> <yves.vandervennet@intel.com>; Ong, Hean Loong
> <hean.loong.ong@intel.com>
> Subject: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
> 
> Enable LED timer trigger for ARM64 to allow LEDs to be controlled via sysfs.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  arch/arm64/configs/defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..b728742 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -471,6 +471,8 @@ CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_PWM=y
>  CONFIG_LEDS_SYSCON=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_LEDS_TRIGGER_CPU=y
>  CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> --
> 1.7.1
