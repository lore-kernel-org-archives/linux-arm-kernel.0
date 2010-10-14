From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Oct 2010 08:30:01 +0200
Subject: mx35pdk lan911x support
In-Reply-To: <AANLkTi=aTdbj8bjo3i1wRxG03rbh=kUwLTYPvTESLqpT@mail.gmail.com>
References: <AANLkTi=aTdbj8bjo3i1wRxG03rbh=kUwLTYPvTESLqpT@mail.gmail.com>
Message-ID: <20101014063001.GA6747@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Xiao (hoping this is the part of your name corresponding to your
first name),

On Thu, Oct 14, 2010 at 12:06:25AM -0400, xiao jiang wrote:
> I saw the mach-mx35_3ds.c  are come from you, so  I think you are the right
> person to answer my queston, :).
It was me, who renamed the file and touched it a few times when cleaning
up and reorganising things for the i.MX machines.  Initially it was
Fabio Estevam who brought the machine into mainline.

I suggest you ask on the linux-arm-kernel mailing (added to Cc:).

> I tried the newest kernel(2.6.36.rc7) to boot mx35pdk board, and selected
> lan911x  not fec as the ethernet port,
> but I failed boot it because the ethernet problem.
> 
> My question is for mx35pdk the kernel support boot from lan911x?
I lost my crystal ball and will only find it next week.  So I'm unable
to see the exact cause of the error.  You might want to follow up with
the kernel boot log and your adaptions to mach-mx35_3ds.c.  You seem not
to have an original 3ds machine, so I'd suggest you register your own
machine type for it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
