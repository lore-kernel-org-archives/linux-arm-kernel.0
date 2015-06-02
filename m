From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 02 Jun 2015 21:59:09 +0900
Subject: [PATCH v4 4/5] ARM: dts: add pinctrl support to Exynos5410
In-Reply-To: <1426456834-6308-5-git-send-email-afaerber@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-5-git-send-email-afaerber@suse.de>
Message-ID: <556DA89D.5010104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 16.03.2015 o 07:00, Andreas F?rber pisze:
> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
> 
> Add the required pin configuration support to Exynos5410 using pinctrl
> interface.
> 
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
> [AF: Rebased, style changes]
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3:
>  * Added wake-up IRQ controller node (Tomasz Figa)
>  
>  v1 -> v2:
>  * Filled in Sob from Hakjoo Kim
>  
>  arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 406 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi         |  36 +++
>  2 files changed, 442 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi

Changes look fine:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
