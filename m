From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:55:28 +0100
Subject: [PATCH v3 03/15] ARM: mxs: Add reset routines
In-Reply-To: <AANLkTikQh4oGOo+mx8MZyBxuPfMJQA2mMQKjY-yCGQ4M@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
	<19711.13516.842225.349704@ipc1.ka-ro>
	<20101208203148.GE17441@pengutronix.de>
	<AANLkTikQh4oGOo+mx8MZyBxuPfMJQA2mMQKjY-yCGQ4M@mail.gmail.com>
Message-ID: <20101209085528.GT17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 04:51:08PM +0800, Shawn Guo wrote:
> static int __init mxs_iomux_init(void)
> {
>         iomux_base = MXS_IO_ADDRESS(MXS_PINCTRL_BASE_ADDR);
> 
>         return 0;
> }
> core_initcall(mxs_iomux_init);
why not simply initialize iomux_base statically?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
