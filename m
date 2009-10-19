From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Oct 2009 09:47:29 +0200
Subject: [PATCH] at91: support for eco920
In-Reply-To: <cd73a99e0910181325i65632137w5250868755fbeb98@mail.gmail.com>
References: <1255378294-10913-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<cd73a99e0910181325i65632137w5250868755fbeb98@mail.gmail.com>
Message-ID: <20091019074729.GA11449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Oct 18, 2009 at 10:25:06PM +0200, Andrew Victor wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>
Fine, thanks.
 
> > I didn't find a suitable defconfig to add this machine to. ?It seems
> > each machine has its own defconfig?!
> 
> Yes, each AT91-based board usually has its own defconfig.
Should I add one for that board?  I'd like to have it enabled in a
defconfig, but I'd prefer to simply enable it in an already existing one
and so don't increase the number of defconfigs.

Thoughts?

Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
