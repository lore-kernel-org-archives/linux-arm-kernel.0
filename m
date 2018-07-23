From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:13:02 +0200
Subject: [PATCH 3/5] ARM: dts: exynos: add pinctrl for midas fuelgauge
 irq pin
In-Reply-To: <20180721125128.31498-4-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-4-simon@lineageos.org>
Message-ID: <20180723171302.bybggn3kdkegigwi@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:50:51PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we should disable the SoC's
> pull down resistor in order for the interrupt to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
