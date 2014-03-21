From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 22:43:02 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Select
 CONFIG_MACH_BERLIN_BG2Q
In-Reply-To: <1395430757-8677-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395430757-8677-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395430757-8677-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532CB266.6050800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 08:39 PM, Alexandre Belloni wrote:
> Now that we support Berlin BG2Q, select CONFIG_MACH_BERLIN_BG2Q so that we can
> boot BG2Q based boards like the BG2Q DMP.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to berlin/soc, Thanks!

> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index ee6982976d66..8b09b72fb688 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ARCH_BCM_MOBILE=y
>   CONFIG_ARCH_BERLIN=y
>   CONFIG_MACH_BERLIN_BG2=y
>   CONFIG_MACH_BERLIN_BG2CD=y
> +CONFIG_MACH_BERLIN_BG2Q=y
>   CONFIG_GPIO_PCA953X=y
>   CONFIG_ARCH_HIGHBANK=y
>   CONFIG_ARCH_HI3xxx=y
>
