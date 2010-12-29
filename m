From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 10:25:26 +0100
Subject: [PATCH v2 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
References: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101229092526.GQ14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 03:30:23PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
> Because common clock is change, I don't send out mx50 clock and board level code.
> But sure I tested the patch series using the clock/board code.
IMHO you can already add the board code and make it depend on BROKEN
with an accompanying comment about the missing clock support.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
