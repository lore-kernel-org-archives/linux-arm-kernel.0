From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2018 22:03:09 -0300
Subject: [PATCH 3/3] ARM: dts: imx31: add LogicPD MX31Lite board
 description
In-Reply-To: <20180703192934.6080-4-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
 <20180703192934.6080-4-vz@mleia.com>
Message-ID: <CAOMZO5CFDUJPoTLppwD6+E5x8gficanore-T-6bGpSEdCwNW0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 4:29 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> The added DTS contains a combined description of LogicPD MX31 Lite
> SoM devices, peripherals are routed to ports on a baseboard:
> * PATA controller,
> * SD/MMC controller,
> * 2 GPIO LEDs,
> * UART controllers,
> * Freescale MC13783 MFD connected over SPI,
> * SMSC LAN9117,
> * ST Micro NAND SLC, 64 MiB,
> * Intel NOR flash, 16 MiB.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
