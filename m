From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 31 Aug 2015 14:42:53 +0900
Subject: [PATCH] arm64: dts: Add BUS1 instance pinctrl support
In-Reply-To: <1440761134-27639-1-git-send-email-alim.akhtar@samsung.com>
References: <1440761134-27639-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <55E3E95D.50003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.08.2015 20:25, Alim Akhtar wrote:
> This adds BUS1 instance pinctrl for exynos7 soc.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  111 +++++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi         |    7 ++
>  2 files changed, 118 insertions(+)

The "etc1" GPIO in my datasheet is not fully documented but the rest
looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
