From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Mar 2011 21:52:36 +0200
Subject: [PATCH 2/2] ARM: mxs/mach-mx23evk: Set the initial value on
	gpio_request_one
In-Reply-To: <1301427910-31726-2-git-send-email-fabio.estevam@freescale.com>
References: <1301427910-31726-1-git-send-email-fabio.estevam@freescale.com>
	<1301427910-31726-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110329195236.GP30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 04:45:10PM -0300, Fabio Estevam wrote:
> Current code does not set the GPIO value to zero as mentioned in the comment.
> 
> Fix it by setting the initial GPIO value to zero.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
If you ask me squash this into patch 1. You can add my Ack independently
of that though.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
