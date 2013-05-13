From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 10:30:03 +0800
Subject: [PATCH 2/2] ARM: mxs: Fix UARTs on M28EVK
In-Reply-To: <1368188795-9114-2-git-send-email-marex@denx.de>
References: <1368188795-9114-1-git-send-email-marex@denx.de>
 <1368188795-9114-2-git-send-email-marex@denx.de>
Message-ID: <20130513023002.GD24494@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 02:26:35PM +0200, Marek Vasut wrote:
> Make use of RTS/CTS lines on AUART0 and register AUART1 and AUART2
> which are routed onto a pin header.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
