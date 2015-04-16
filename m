From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 Apr 2015 19:04:03 +0300
Subject: [PATCH] ARM: multi_v7_defconfig: Enable shmobile r8a7778 (M1A)
In-Reply-To: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1429196897-18822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <552FDD73.70805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/16/2015 06:08 PM, Ulrich Hecht wrote:

> Also enables RTC (RX8581) and camera (ML86V7667) drivers as modules.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 06075b6..212199a 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
[...]
> @@ -500,6 +502,7 @@ CONFIG_RTC_DRV_SUN6I=y
>   CONFIG_RTC_DRV_SUNXI=y
>   CONFIG_RTC_DRV_MV=y
>   CONFIG_RTC_DRV_TEGRA=y
> +CONFIG_RTC_DRV_RX8581=m

    The other RTC drivers seem to be built-in.

WBR, Sergei
