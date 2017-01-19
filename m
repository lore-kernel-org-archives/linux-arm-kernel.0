From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 09:56:35 -0200
Subject: [PATCH 1/4] ARM: dts: imx7s-warp: Fix watchdog pinmux
In-Reply-To: <20170119090924.19636-2-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
 <20170119090924.19636-2-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5D9UAi_mJ4UmVuUXT-=dcvSjFyPDwLssyBL1Nr88kQpQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 7:09 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The watchdog pin is controlled by the iomuxc_lpsr, not the regular
> iomux, so move it there.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
