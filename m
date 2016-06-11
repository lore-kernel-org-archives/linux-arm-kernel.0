From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 11 Jun 2016 14:56:19 +0800
Subject: [PATCH] ARM: dts: imx6: fix IPU1 DI1 node name
In-Reply-To: <1464706177-30330-1-git-send-email-l.stach@pengutronix.de>
References: <1464706177-30330-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160611065619.GE20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 04:49:37PM +0200, Lucas Stach wrote:
> From: Juergen Borleis <jbe@pengutronix.de>
> 
> This node describes the DI1 port of IPU, fix the node name to reflect this.
> There's currently no user of this node in mainline, so this change should
> not break any supported platforms.
> 
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
