From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Nov 2018 11:02:14 +0800
Subject: [PATCH] ARM: dts: imx6: RDU2: fix eGalax touchscreen node
In-Reply-To: <20181105173156.3519-1-l.stach@pengutronix.de>
References: <20181105173156.3519-1-l.stach@pengutronix.de>
Message-ID: <20181116030212.GI5829@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 06:31:56PM +0100, Lucas Stach wrote:
> Use the correct compatible for the new protocol used by the firmware
> on the touch controller, the GPIO wakeup isn't used in that case.
> Also eGalax touch needs axis swapping, just as with the RMI4 touch.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
