From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Feb 2018 12:44:03 -0200
Subject: [PATCH] ARM: dts: imx6: RDU2: detail USDHC description
In-Reply-To: <20180212130818.12665-1-l.stach@pengutronix.de>
References: <20180212130818.12665-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5C_qaM69VXS1zF45ZZsc1sLdWB3sxNLeGaG3cXP7+E_=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 11:08 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> None of the slots support 1.8V signaling or SDIO. There is no point in
> probing for a SD card on the eMMC controller.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
