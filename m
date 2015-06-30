From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 30 Jun 2015 09:16:22 +0900
Subject: [PATCH v2 3/4] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos5250
In-Reply-To: <1435598772-21708-4-git-send-email-b.zolnierkie@samsung.com>
References: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
 <1435598772-21708-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5591DFD6.1000408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.06.2015 02:26, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The new CPU clock type allows the use of generic CPUfreq driver.
> Switch Exynos5250 to using generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
