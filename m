From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 6 Jan 2015 11:31:14 -0400
Subject: [PATCH 17/17] ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I,
 CPU_THERMAL
In-Reply-To: <1420511727-8242-18-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-18-git-send-email-wens@csie.org>
Message-ID: <20150106153111.GF6276@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:35:27AM +0800, Chen-Yu Tsai wrote:
> This patch enables TOUCHSCREEN_SUN4I and CPU_THERMAL to enable cpufreq
> support with passive cpu cooling (thermal throttling) on sunxi by default.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

for the CPU_THERMAL

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2328fe752e9c..0e7159ad269b 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -189,6 +189,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=y
>  CONFIG_TOUCHSCREEN_STMPE=y
> +CONFIG_TOUCHSCREEN_SUN4I=y
>  CONFIG_INPUT_MISC=y
>  CONFIG_INPUT_MPU3050=y
>  CONFIG_SERIO_AMBAKMI=y
> @@ -267,6 +268,7 @@ CONFIG_POWER_RESET_SUN6I=y
>  CONFIG_SENSORS_LM90=y
>  CONFIG_SENSORS_LM95245=y
>  CONFIG_THERMAL=y
> +CONFIG_CPU_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
>  CONFIG_ST_THERMAL_SYSCFG=y
>  CONFIG_ST_THERMAL_MEMMAP=y
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/5c411822/attachment.sig>
