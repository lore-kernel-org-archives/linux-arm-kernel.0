From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Apr 2018 17:11:30 +0800
Subject: [PATCH 1/3] ARM: dts: imx6: RDU2: bump SoC/PU operating points
 by 25mV
In-Reply-To: <20180412131556.11073-1-l.stach@pengutronix.de>
References: <20180412131556.11073-1-l.stach@pengutronix.de>
Message-ID: <20180423091128.GC25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 03:15:54PM +0200, Lucas Stach wrote:
> This bumps the SoC/PU domain operating points by 25mV, giving a total
> of 75mV margin to the minimum required voltages. This gets rid of
> brown-outs seen due to voltage drop-out on the board.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied all, thanks.
