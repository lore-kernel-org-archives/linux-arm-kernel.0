From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Jan 2017 14:43:15 +0800
Subject: [PATCH 1/2] ARM: imx6: fix min/max voltage of anatop 2p5 regulator
In-Reply-To: <20170119142134.8572-1-l.stach@pengutronix.de>
References: <20170119142134.8572-1-l.stach@pengutronix.de>
Message-ID: <20170124064313.GS5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 03:21:33PM +0100, Lucas Stach wrote:
> The regulation bound of this regulator are 2.1V to 2.875V, the
> wrong DT values cause the driver to miscalculate the effective
> voltage.
> 
> This isn't really an issue right now, as nobody actively changes
> the regulator voltage, but better fix it now.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied both, thanks.
