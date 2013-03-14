From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 09:10:36 +0000
Subject: [PATCH v4 5/5] ARM: config: append arch hi3xxx into multi
 defconfig
In-Reply-To: <1363245584-24488-6-git-send-email-haojian.zhuang@linaro.org>
References: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
 <1363245584-24488-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303140910.36483.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Haojian Zhuang wrote:
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -5,6 +5,7 @@ CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_ARCH_HIGHBANK=y
> +CONFIG_ARCH_HI3xxx=y
>  CONFIG_ARCH_SOCFPGA=y
>  CONFIG_ARCH_SUNXI=y
>  # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set

Are you sure this is enough? Normally we also have to enable
some device drivers to get a bootable system.

	Arnd
