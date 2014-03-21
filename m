From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 22:42:42 +0100
Subject: [PATCH 1/2] ARM: berlin: add MACH_BERLIN_BG2Q symbol
In-Reply-To: <1395430757-8677-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395430757-8677-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <532CB252.6010702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 08:39 PM, Alexandre Belloni wrote:
> Now that we start supporting the Marvell Berlin BG2Q, add a symbol allowing to
> differentiate that SoC from the other SoCs of the Berlin family.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to berlin/defconfig, Thanks!

> ---
>   arch/arm/mach-berlin/Kconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index 7a02d222c378..0ff6f5877076 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -24,6 +24,13 @@ config MACH_BERLIN_BG2CD
>   	select CPU_V7
>   	select HAVE_ARM_TWD if SMP
>
> +config MACH_BERLIN_BG2Q
> +	bool "Marvell Armada 1500 Pro (BG2-Q)"
> +	select CACHE_L2X0
> +	select CPU_V7
> +	select HAVE_ARM_TWD if SMP
> +	select HAVE_SMP
> +
>   endmenu
>
>   endif
>
