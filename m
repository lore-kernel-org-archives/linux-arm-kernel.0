From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 19:57:03 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Enable perf support in
 mvebu_v7_defconfig
In-Reply-To: <1425379400-4346-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1425379400-4346-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54F603FF.8080605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 03/03/2015 11:43, Maxime Ripard wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> Now that Armada 375/38x have support for the PMU, this commit enables perf
> events in the defconfig.



Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index 73673e95f23c..b53606cdff26 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -5,6 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
