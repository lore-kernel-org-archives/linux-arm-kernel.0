From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 May 2014 15:52:07 +0200
Subject: [PATCH v9 10/14] ARM: config: append lpae configuration
In-Reply-To: <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <537B5E07.6090206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On 20/05/2014 15:10, Haojian Zhuang wrote:
> Append multi_v7_lpae_config. In this default configuration,
> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/configs/multi_v7_lpae_defconfig | 351 +++++++++++++++++++++++++++++++
>  1 file changed, 351 insertions(+)
>  create mode 100644 arch/arm/configs/multi_v7_lpae_defconfig
> 
> diff --git a/arch/arm/configs/multi_v7_lpae_defconfig b/arch/arm/configs/multi_v7_lpae_defconfig
> new file mode 100644
> index 0000000..59fcefc
> --- /dev/null
> +++ b/arch/arm/configs/multi_v7_lpae_defconfig
> @@ -0,0 +1,351 @@

[...]


> +CONFIG_MACH_ARMADA_370=y
> +CONFIG_MACH_ARMADA_375=y
> +CONFIG_MACH_ARMADA_38X=y
> +CONFIG_MACH_ARMADA_XP=y
> +CONFIG_MACH_DOVE=y

Among them only ARMADA_XP is LPAE capable


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
