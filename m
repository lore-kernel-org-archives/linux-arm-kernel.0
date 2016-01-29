From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Jan 2016 09:11:32 +0900
Subject: [UPDATE] [PATCH 12/19] ARM: dts: exynos: replace legacy *, wakeup
 property with wakeup-source
In-Reply-To: <1453996798-10711-1-git-send-email-sudeep.holla@arm.com>
References: <56A9CD1A.8010800@samsung.com>
 <1453996798-10711-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <56AAAE34.30007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.01.2016 00:59, Sudeep Holla wrote:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "linux-keypad,wakeup" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
> 
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/exynos3250-monk.dts           |  6 +++---
>  arch/arm/boot/dts/exynos3250-rinato.dts         |  6 +++---
>  arch/arm/boot/dts/exynos4210-origen.dts         | 10 +++++-----
>  arch/arm/boot/dts/exynos4210-smdkv310.dts       |  2 +-
>  arch/arm/boot/dts/exynos4210-trats.dts          |  2 +-
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 ++--
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  2 +-
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |  2 +-
>  arch/arm/boot/dts/exynos4412-origen.dts         |  2 +-
>  arch/arm/boot/dts/exynos4412-smdk4412.dts       |  2 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts         |  4 ++--
>  arch/arm/boot/dts/exynos5250-arndale.dts        | 12 ++++++------
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi   |  4 ++--
>  arch/arm/boot/dts/exynos5250-spring.dts         |  4 ++--
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      |  4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       |  4 ++--
>  17 files changed, 36 insertions(+), 36 deletions(-)
> 
> Hi Krzysztof,
> 
> Thanks for picking up on this. I have rebased on:
> git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git next/dt

Thanks!

Applied for v4.6.

Best regards,
Krzysztof
