From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:18:07 +0900
Subject: [PATCH v5 4/7] ARM: Exynos: use generic cpufreq driver for
 Exynos5420
In-Reply-To: <1449766729-435-5-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A244F.7020208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> The new CPU clock type allows the use of cpufreq-dt driver
> for Exynos5420.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
