From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 16 Dec 2015 09:43:57 +0900
Subject: [PATCH v6 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <1450200801-24539-4-git-send-email-b.zolnierkie@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
 <1450200801-24539-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5670B3CD.8010604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.12.2015 02:33, Bartlomiej Zolnierkiewicz wrote:
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
>  arch/arm/boot/dts/exynos5420-cpus.dtsi |  10 +++
>  arch/arm/boot/dts/exynos5420.dtsi      | 110 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi |  10 +++
>  3 files changed, 130 insertions(+)
> 

Thanks for rebasing on "exynos5422-cpus.dtsi" patch, I appreciate this.

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
