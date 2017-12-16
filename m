From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 10:47:26 -0200
Subject: [PATCH] ARM: dts: imx6q-h100: use usdhc2 VSELECT
In-Reply-To: <20171215092624.12806-1-m.tretter@pengutronix.de>
References: <20171215092624.12806-1-m.tretter@pengutronix.de>
Message-ID: <CAOMZO5BrhAYSVPUUm3T1bkW6ug=+zOOB7EcXO5eBunUG5uOY3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Fri, Dec 15, 2017 at 7:26 AM, Michael Tretter
<m.tretter@pengutronix.de> wrote:
> The uSDHC controller directly provides a VSELECT signal that can be
> muxed to the external voltage select. Mux the VSELECT directly to avoid
> using a GPIO.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Much simpler :-)

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
