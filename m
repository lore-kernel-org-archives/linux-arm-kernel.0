From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Mar 2011 15:42:53 -0800
Subject: [PATCH v2] ARM: tegra: seaboard: register i2c devices
In-Reply-To: <1299540862-3848-1-git-send-email-olof@lixom.net>
References: <1299540862-3848-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687B99F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Monday, March 07, 2011 4:34 PM:
> Register the base i2c devices on seaboard. A few more are pending,
> but it's a start.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-seaboard-pinmux.c |    1 +
>  arch/arm/mach-tegra/board-seaboard.c        |   62
> +++++++++++++++++++++++++--
>  2 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-
> tegra/board-seaboard-pinmux.c
> index 7e96d49..d84d1dd 100644
> --- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
> +++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
> @@ -166,6 +166,7 @@ static struct tegra_gpio_table gpio_table[] = {
>  	{ .gpio = TEGRA_GPIO_SD2_POWER,		.enable = true },
>  	{ .gpio = TEGRA_GPIO_LIDSWITCH,		.enable = true },
>  	{ .gpio = TEGRA_GPIO_POWERKEY,		.enable = true },
> +	{ .gpio = TEGRA_GPIO_ISL29018_IRQ, 	.enable = true },

There's a space after "_IRQ," here. I think that's what's throwing off
the display in my crappy email reader.

Aside from that,

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
