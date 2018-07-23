From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:13:11 +0200
Subject: [PATCH 4/5] ARM: dts: exynos: configure max77686 IRQ pin on midas
In-Reply-To: <20180721125128.31498-5-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-5-simon@lineageos.org>
Message-ID: <20180723171311.mowgm3j3ikdhnj36@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:50:52PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we need to disable the
> SoC's internal pull-down.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
