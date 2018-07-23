From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 23 Jul 2018 19:13:20 +0200
Subject: [PATCH 5/5] ARM: dts: exynos: configure midas SD card CD pin
In-Reply-To: <20180721125128.31498-6-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
 <20180721125128.31498-6-simon@lineageos.org>
Message-ID: <20180723171320.zkutp24l5xva6ghh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:50:53PM +1000, Simon Shields wrote:
> This pin is externally pulled up, so we need to disable the SoC's
> internal pull down resistor to allow it to function properly.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof
