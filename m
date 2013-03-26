From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 13:36:43 +0800
Subject: [PATCH 0/2] mmc: mxs-mmc: add cd-inverted and non-removeable
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20130326053641.GC5148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 04:02:29PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch add support for the cd-inverted and non-removeable property (as
> defined in devicetree/bindings/mmc/mmc.txt) to the mxs-mmc driver. Tested on a
> custom imx28 board.
> 
> This series applies to Chris Ball's cjb/mmc-next branch.

For both,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
