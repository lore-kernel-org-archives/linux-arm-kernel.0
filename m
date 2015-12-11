From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 10:27:20 +0900
Subject: [PATCH v5 6/7] ARM: dts: Exynos5800: fix CPU OPP
In-Reply-To: <1449766729-435-7-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-7-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <566A2678.7090500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> Fix CPU operating points for Exynos5800 (it use different
> voltages than Exynos5420 and supports additional frequencies).
> However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
> 1400MHz OPP (for A7 cores) for now as they are not available
> on all boards.
> 
> Based on Hardkernel's kernel for ODROID-XU3 board.
> 
> Changes by Ben Gamari:
> - Port to operating-points-v2
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5800.dtsi | 108 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
