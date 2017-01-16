From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Jan 2017 16:35:26 -0200
Subject: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
In-Reply-To: <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Only i.MX35 and newer feature a WMCR register that should be written to. Older
> SoCs hang when this address is written.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Only a minor nit: Subject could: ARM: dts: imx: teach...
