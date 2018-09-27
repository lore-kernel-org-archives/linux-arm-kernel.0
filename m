From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 14:14:50 -0500
Subject: [PATCh v3 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180921125626.21971-2-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
 <20180921125626.21971-2-l.stach@pengutronix.de>
Message-ID: <20180927191450.GA32039@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 02:56:24PM +0200, Lucas Stach wrote:
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
> +#define MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0                                 0x0A8 0x310 0x000 0x0 0x0
> +#define MX8MQ_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x31  0x000 0x5 0x0

The 0x31 looks suspicious.

And checkpatch isn't happy about the spaces instead of tabs.

Rob

> +#define MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1                                 0x0AC 0x314 0x000 0x0 0x0
