From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 08:54:59 +0800
Subject: [PATCH] ARM: mx5: Fix MX53 flexcan2 clock
In-Reply-To: <20130107171224.GA13025@pengutronix.de>
References: <1357568820-15426-1-git-send-email-marex@denx.de>
 <20130107171224.GA13025@pengutronix.de>
Message-ID: <20130108005455.GF29281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 06:12:24PM +0100, Sascha Hauer wrote:
> On Mon, Jan 07, 2013 at 03:27:00PM +0100, Marek Vasut wrote:
> > The second FlexCAN port uses different clock than the first one, configure
> > correct clock to prevent hanging of the system during bringing up of the port.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> 
> Looks Good.
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied, thanks.
