From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 17 Jul 2017 12:47:10 +0100
Subject: [PATCH 4/6] ARM: vexpress_defconfig: Cleanup from non-existing
 options
In-Reply-To: <1500270596-22384-4-git-send-email-krzk@kernel.org>
References: <1500270596-22384-1-git-send-email-krzk@kernel.org>
 <1500270596-22384-4-git-send-email-krzk@kernel.org>
Message-ID: <20170717114710.GR3532@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 07:49:54AM +0200, Krzysztof Kozlowski wrote:
> ARCH_VEXPRESS_CA9X4 is gone since commit 81cc3f868d30 ("ARM: vexpress:
> Remove non-DT code").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks for the cleanup!

Best regards,
Liviu

> ---
>  arch/arm/configs/vexpress_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index 0fa0ed577b15..edae1c58fe80 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -19,7 +19,6 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_VEXPRESS=y
> -CONFIG_ARCH_VEXPRESS_CA9X4=y
>  CONFIG_ARCH_VEXPRESS_DCSCB=y
>  CONFIG_ARCH_VEXPRESS_TC2_PM=y
>  # CONFIG_SWP_EMULATE is not set
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
