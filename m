From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 12 Nov 2018 18:06:13 +0000
Subject: [PATCh v3 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180921125626.21971-2-l.stach@pengutronix.de>
References: <20180921125626.21971-1-l.stach@pengutronix.de>
 <20180921125626.21971-2-l.stach@pengutronix.de>
Message-ID: <AM0PR04MB421192D863C2AE7C4CD35A1580C10@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Friday, September 21, 2018 8:56 PM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> patchwork-lst at pengutronix.de; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCh v3 2/4] arm64: add basic DTS for i.MX8MQ
> 
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
> 
> One known limitation is that the driver for the GPC interrupt
> controller is still missing, rendering the CPU sleep states unusable
> as there is nothing waking them up anymore.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Can you send a updated version of this patch series against the latest
Composite clock drivers?
Then we can get a ready to merge version and then can be easily applied
once clock is merged.

Regards
Dong Aisheng
