From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Jan 2017 20:53:36 +0800
Subject: [PATCH] ARM: imx6: remove unit address from LDB node
In-Reply-To: <20170120164401.5904-1-l.stach@pengutronix.de>
References: <20170120164401.5904-1-l.stach@pengutronix.de>
Message-ID: <20170124125334.GV5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 05:44:01PM +0100, Lucas Stach wrote:
> The LDB has no reg property as it uses the IOMUX-GPR syscon to access
> its registers. Remove the unit address from the DT node to make DT
> compiler happy.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
