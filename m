From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Jan 2017 20:51:43 +0800
Subject: [PATCH] ARM: imx6qp: adapt DT to changed FEC interrupts
In-Reply-To: <20170120161740.19765-1-l.stach@pengutronix.de>
References: <20170120161740.19765-1-l.stach@pengutronix.de>
Message-ID: <20170124125142.GU5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 05:17:40PM +0100, Lucas Stach wrote:
> On i.MX6QP the FEC interrupts are wired to the GPC, just like all other
> device interrupts. This allows to FEC to wake the CPU from WFI, but for
> this to work the kernel needs to know about the new IRQ routing.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
