From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 10:16:13 +0100
Subject: [PATCH 1/3] ARM: mx5: add support for the two watchdog modules
In-Reply-To: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
References: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101207091613.GD21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 04:38:32PM -0200, Fabio Estevam wrote:
> MX51 has two watchdog modules.
> 
> Add support for both of them.
I don't know why you need two watchdogs, but the patches look OK.

Note there is a conflict between this patch series and the clk-change
for the watchdog driver.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
