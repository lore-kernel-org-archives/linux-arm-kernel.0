From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:27:39 +0900
Subject: [PATCH v5 7/7] ARM: Exynos: use generic cpufreq driver for
 Exynos5422/5800
In-Reply-To: <1449766729-435-8-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-8-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A268B.8080404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> The new CPU clock type allows the use of generic cpufreq-dt driver
> for Exynos5422/5800.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
