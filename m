From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 11:55:49 -0600
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180117183244.28303-2-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
Message-ID: <20180129175549.f6ljaccpo5ms6xkc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:32:42PM +0100, Lucas Stach wrote:
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c
> 
> This is enough to get a very basic board support up and running.

> +			compatible = "nxp,imx8mq-aips-bus", "simple-bus";
> +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> +				compatible = "nxp,imx8mq-iomuxc";

Also, are all these new compatibles documented?

Rob
