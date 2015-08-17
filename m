From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Aug 2015 09:33:43 +0900
Subject: [PATCH 0/4] ARM: dts: exynos3250: Add UART2 and MMC2 dt node with
 related clocks
In-Reply-To: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
References: <1439264784-30322-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAJKOXPfvGypFymHzXDMEA295Copi0sjpMG9oKmJ+a_BQoK+SNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-11 12:46 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> This patch add the UART2 / MMC2 devicetree node for Exynos3250 SoC and add
> the related clocks (mux, divider, gate) of UART2 / MMC2 device.

What is the benefit of adding them? Why they are needed?

Best regards,
Krzysztof


>
> Chanwoo Choi (4):
>   clk: samsung: exynos3250: Add UART2 clock
>   clk: samsung: exynos3250: Add MMC2 clock
>   ARM: dts: Add UART2 dt node for Exynos3250 SoC
>   ARM: dts: Add MSHC2 dt node for Exynos3250 SoC
>
>  arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 42 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250.dtsi         | 25 ++++++++++++++++++
>  drivers/clk/samsung/clk-exynos3250.c      | 15 +++++++++++
>  include/dt-bindings/clock/exynos3250.h    | 11 +++++++-
>  4 files changed, 92 insertions(+), 1 deletion(-)
>
> --
> 1.8.5.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
