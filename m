From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 29 Dec 2010 17:33:03 +0800
Subject: [PATCH v2 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <20101229092526.GQ14221@pengutronix.de>
References: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
	<20101229092526.GQ14221@pengutronix.de>
Message-ID: <20101229093302.GA16730@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 10:25:26AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Dec 29, 2010 at 03:30:23PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> > Because common clock is change, I don't send out mx50 clock and board level code.
> > But sure I tested the patch series using the clock/board code.
> IMHO you can already add the board code and make it depend on BROKEN
> with an accompanying comment about the missing clock support.
Great!

Thanks
Richard
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
