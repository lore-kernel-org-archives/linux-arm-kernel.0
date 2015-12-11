From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:16:00 +0900
Subject: [PATCH v5 1/7] ARM: dts: Exynos542x/5800: add cluster regulator
 supply properties
In-Reply-To: <1449766729-435-2-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A23D0.9060402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> Add cluster regulator supply properties as a preparation to
> adding generic cpufreq-dt driver support for Exynos542x and
> Exynos5800 based boards.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 8 ++++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         | 8 ++++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          | 8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 ++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          | 8 ++++++++
>  5 files changed, 40 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
