From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 14:36:10 +0800
Subject: [PATCH] arm: imx6qp: correct LDB clock inputs
In-Reply-To: <20161108165536.19656-1-l.stach@pengutronix.de>
References: <20161108165536.19656-1-l.stach@pengutronix.de>
Message-ID: <20161114063608.GI3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 05:55:36PM +0100, Lucas Stach wrote:
> On i.MX6QP the LDB clock tree has changed to move the clk gate
> before the divider, to prevent clock glitches propagating downstream.
> 
> A consequence of this change is that the clk divider is now the
> parent of the LDB inputs. Reflect this change in the devicetree
> to allow the LDB driver to properly configure the display clocks.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
