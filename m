From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Jan 2018 16:52:22 -0200
Subject: [PATCH] clk: imx: pllv2: avoid using uninitialized values
In-Reply-To: <20180117150256.7430-1-l.stach@pengutronix.de>
References: <20180117150256.7430-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5Db5TMQ2ugG1NumVnxuBPiS23R1WUOvbqpc0N2U1eFTzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 1:02 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Forward the errors returned by __clk_pllv2_set_rate() in the recalc rate
> function, to avoid using uninitialized values for the rate calculation.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks
