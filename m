From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Jan 2011 08:43:55 +0100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <AANLkTikC0ZV6pZ7jVmZ5DSrrkPCN4UPn3VY+zM2RWSc6@mail.gmail.com>
References: <20110111110539.GP24920@pengutronix.de>
	<201101181759.32013.maciej.rutecki@gmail.com>
	<AANLkTikC0ZV6pZ7jVmZ5DSrrkPCN4UPn3VY+zM2RWSc6@mail.gmail.com>
Message-ID: <20110119074355.GF10686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 09:19:59AM +1100, Nick Piggin wrote:
> 2011/1/19 Maciej Rutecki <maciej.rutecki@gmail.com>:
> > I created a Bugzilla entry at
> > https://bugzilla.kernel.org/show_bug.cgi?id=27032
> > for your bug report, please add your address to the CC list in there, thanks!
> 
> Sorry I missed this mail. This bug should have been fixed several
> days ago 90dbb77ba48dddb87445d238e84cd137cf97dd98
Yesterday I retryed Linus' tree (which has the commit 90dbb77ba) and the
spinlock recursion is gone.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
