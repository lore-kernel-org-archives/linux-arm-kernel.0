From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 21 Oct 2015 09:14:02 +0900
Subject: [PATCH v2 5/6] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <1445333085-22837-6-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <1445333085-22837-6-git-send-email-alim.akhtar@samsung.com>
Message-ID: <5626D8CA.7000505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 18:24, Alim Akhtar wrote:
> Since we switch to use generic syscon regmap based reset/poweroff
> driver for exynos SoC, lets select it from ARCH_EXYNOS instead of
> enabling it from various defconfigs. This also select POWER_RESET
> as SYSCON-{reset, poweroff} drivers depends on it.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> 
> Have run make for allyes, allmod, multi_v7 and exynos defconfigs
> no error/warrning reported.
> 
>  arch/arm/mach-exynos/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)

Thanks for update:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
