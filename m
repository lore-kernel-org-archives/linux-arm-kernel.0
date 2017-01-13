From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jan 2017 21:16:32 -0200
Subject: [PATCH] clk: imx6: don't restrict LDB mux changes on QuadPlus
In-Reply-To: <20170113173943.23677-1-l.stach@pengutronix.de>
References: <20170113173943.23677-1-l.stach@pengutronix.de>
Message-ID: <CAOMZO5C3917JYzknLqmTBTR7Vs1EM3Dv=wQb2Xe6QnjWpvDn+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 3:39 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> The LDB mux/gate layout has been fixed on QuadPlus, so there is no need
> to restrict the LDB mux changes on this hardware, as the erratum
> preventing this from working properly is gone.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

That's correct: mx6qp does not suffer from the LDB clock glitch issue:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
