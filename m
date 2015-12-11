From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:17:40 +0900
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A2434.9080200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos542x/5800 platforms, add CPU operating points
> for migrating from Exynos specific cpufreq driver to using
> generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> - merged Exynos5422 fixes from Ben
> 
> Changes by Ben Gamari:
> - Port to operating-points-v2
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi      | 122 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi |  10 +++
>  2 files changed, 132 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
