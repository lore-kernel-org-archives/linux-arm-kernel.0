From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 07 Oct 2013 16:52:05 +0200
Subject: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
In-Reply-To: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5252CA95.8000405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2013 01:36 PM, Daniel Lezcano wrote:
> With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
> ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
> default config file, hence the cpuidle driver is no longer enabled
> since this commit.
>
> Enable it again by adding the missing option in the default config file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Olof, Linus,

any comment on this patch ? Are you willing to pick it in your tree ?

Thanks
   -- Daniel

>   arch/arm/configs/u8500_defconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
> index a0025dc..4bd93bf 100644
> --- a/arch/arm/configs/u8500_defconfig
> +++ b/arch/arm/configs/u8500_defconfig
> @@ -20,6 +20,7 @@ CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
>   CONFIG_CPU_FREQ=y
>   CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>   CONFIG_CPU_IDLE=y
> +CONFIG_ARM_U8500_CPUIDLE=y
>   CONFIG_VFP=y
>   CONFIG_NEON=y
>   CONFIG_PM_RUNTIME=y
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
