From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 09:13:53 +0900
Subject: [PATCH] MAINTAINERS: Add missing platform maintainers for dts
 files
In-Reply-To: <1449790703-12054-1-git-send-email-robh@kernel.org>
References: <1449790703-12054-1-git-send-email-robh@kernel.org>
Message-ID: <566A1541.5050201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 08:38, Rob Herring wrote:
> Platform dts files need to be reviewed primarily by the platform
> maintainers as dts files typically go in thru their trees. Add the missing
> paths where there are existing maintainers listed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 69c8a9c..415b731 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -950,6 +950,8 @@ M:	Rob Herring <robh@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-highbank/
> +F:	arch/arm/boot/dts/highbank.dts
> +F:	arch/arm/boot/dts/ecx-*.dts*
>  
>  ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
>  M:	Krzysztof Halasa <khalasa@piap.pl>
> @@ -1025,6 +1027,7 @@ M:	Barry Song <baohua@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
>  S:	Maintained
> +F:	arch/arm/boot/dts/prima2*
>  F:	arch/arm/mach-prima2/
>  F:	drivers/clk/sirf/
>  F:	drivers/clocksource/timer-prima2.c
> @@ -1126,6 +1129,10 @@ W:	http://www.hisilicon.com
>  S:	Supported
>  T:	git git://github.com/hisilicon/linux-hisi.git
>  F:	arch/arm/mach-hisi/
> +F:	arch/arm/boot/dts/hi3*
> +F:	arch/arm/boot/dts/hip*
> +F:	arch/arm/boot/dts/hisi*
> +F:	arch/arm64/boot/dts/hisilicon/
>  
>  ARM/HP JORNADA 7XX MACHINE SUPPORT
>  M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
> @@ -1202,6 +1209,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-keystone/
> +F:	arch/arm/boot/dts/k2*
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>  
>  ARM/TEXAS INSTRUMENT KEYSTONE CLOCK FRAMEWORK
> @@ -1270,6 +1278,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-berlin/
>  F:	arch/arm/boot/dts/berlin*
> +F:	arch/arm64/boot/dts/marvell/berlin*
>  
>  
>  ARM/Marvell Dove/MV78xx0/Orion SOC support
> @@ -1406,7 +1415,9 @@ M:	David Brown <davidb@codeaurora.org>
>  L:	linux-arm-msm at vger.kernel.org
>  L:	linux-soc at vger.kernel.org
>  S:	Maintained
> +F:	arch/arm/boot/dts/qcom-*
>  F:	arch/arm/mach-qcom/
> +F:	arch/arm64/boot/dts/qcom/*
>  F:	drivers/soc/qcom/
>  F:	drivers/tty/serial/msm_serial.h
>  F:	drivers/tty/serial/msm_serial.c
> @@ -1456,6 +1467,8 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/boot/dts/s3c*
> +F:	arch/arm/boot/dts/s5p*
> +F:	arch/arm/boot/dts/samsung*
>  F:	arch/arm/boot/dts/exynos*
>  F:	arch/arm64/boot/dts/exynos/
>  F:	arch/arm/plat-samsung/

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
