From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 16:23:03 +0100
Subject: [PATCH 1/3] ARM: dts: Leave Exynos5250 SPI controller disabled by
 default
In-Reply-To: <1385381710-5212-1-git-send-email-broonie@kernel.org>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
Message-ID: <5026211.5mW8H3pyKS@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Monday 25 of November 2013 12:15:08 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Rather than requiring each board to explicitly disable the SPI controllers
> it is not using instead require boards to enable those that they are using.
> This is less work overall since normally at most one of the controllers is
> in use and avoids issues caused by inappropriate pinmuxing.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/cros5250-common.dtsi    |  9 +--------
>  arch/arm/boot/dts/exynos5250-arndale.dts  | 12 ------------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |  6 ++----
>  arch/arm/boot/dts/exynos5250.dtsi         |  3 +++
>  4 files changed, 6 insertions(+), 24 deletions(-)

Seems like you have missed this series. Could you apply it?

Best regards,
Tomasz
