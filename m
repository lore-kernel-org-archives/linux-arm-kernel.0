From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Jun 2017 13:45:35 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
In-Reply-To: <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> +                       tempmon: tempmon {
> +                               compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> +                               interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +                               fsl,tempmon = <&anatop>;
> +                               fsl,tempmon-data = <&ocotp>;
> +                               clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;

Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
double check.
