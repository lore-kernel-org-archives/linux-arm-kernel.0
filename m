From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jan 2018 09:57:01 -0200
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180117183244.28303-2-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
Message-ID: <CAOMZO5C1sBqO=92KmoEn8YOBe4C_K3PZ=quxC6es8ia4giKQNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 4:32 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
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
> as there is nothing waking them up anymore. This will be fixed in
> due course.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
