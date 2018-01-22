From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jan 2018 09:53:45 -0200
Subject: [PATCH 1/4] ARM64: add basic Kconfig symbols for i.MX8
In-Reply-To: <20180117183244.28303-1-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5D_siLLeAKkqDYA3w=uRLnc+aV6G_JDQHuGcO2gmKL-+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:32 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/Kconfig.platforms |  6 ++++++
>  drivers/soc/imx/Kconfig      | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 2401373565ff..2a22802d1f9e 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -131,6 +131,12 @@ config ARCH_MVEBU
>            - Armada 7K SoC Family
>            - Armada 8K SoC Family
>
> +config ARCH_MXC
> +       bool "ARMv8 based NXP i.MX SoC family"
> +       help
> +         This enabled support for the ARMv8 based SoCs in the

s/enabled/enables

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
