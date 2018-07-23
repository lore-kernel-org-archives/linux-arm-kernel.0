From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:12:52 +0200
Subject: [PATCH 2/5] ARM: dts: exynos: add pinctrl config for midas keys
In-Reply-To: <20180721125128.31498-3-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-3-simon@lineageos.org>
Message-ID: <20180723171252.2z2sdetuan4snoq2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:50:50PM +1000, Simon Shields wrote:
> This pins are externally pulled up, and so we should explicitly
> configure them to disable the SoC-internal pull-downs. Previously
> we relied on the bootloader doing this in order to allow the buttons
> to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied.

Best regards,
Krzysztof
