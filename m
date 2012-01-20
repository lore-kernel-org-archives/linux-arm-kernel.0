From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 21 Jan 2012 00:29:12 +0100
Subject: [PATCH 1/3] ARM: mx3: Remove unneeded ifdef's from mm-imx3.c
In-Reply-To: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
References: <1327084990-25402-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120120232912.GP4066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 04:43:08PM -0200, Fabio Estevam wrote:
> As we are already able to build a kernel that can run on mx31 and mx35, there
> is no need for the ifdef's anymore, so remove them.
They were introduced in commit 

	87514fc (ARM: imx/mm-imx3: conditionally compile i.MX31 and i.MX35 code)

and the problem was not that we can or cannot do kernels for both mx31
and mx35, but that we also want to do kernels for only one of them. Did
you try to build an mx31-only kernel after your change?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
