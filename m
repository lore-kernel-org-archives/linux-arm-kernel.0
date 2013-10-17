From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Oct 2013 11:21:29 +0200
Subject: [PATCH v2 13/13] arm64: add CPU power management menu/entries
In-Reply-To: <1381748590-14279-14-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-14-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <525FAC19.40503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 01:03 PM, Lorenzo Pieralisi wrote:
> This patch provides a menu for CPU power management options in the
> arm64 Kconfig and adds an entry to enable the generic CPU idle configuration.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm64/Kconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index be88acd..785132d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -288,6 +288,12 @@ config ARM64_CPU_SUSPEND
>
>   endmenu
>
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>   source "net/Kconfig"
>
>   source "drivers/Kconfig"
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
