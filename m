From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 21:34:16 +0200
Subject: [RFC] filter function for submaintainers
In-Reply-To: <20110406190313.GA767@pengutronix.de>
References: <20110404161716.GG13963@pengutronix.de>
	<20110404170049.GA12200@pengutronix.de>
	<20110404170515.GF7285@pengutronix.de>
	<20110406190313.GA767@pengutronix.de>
Message-ID: <20110406193416.GB767@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

at Pengutronix we think about using patchwork for the imx maintenance of
the kernel. (That is all related to arch/arm/{mach-{imx,mx*},plat-mxc}.)

The problem (admittedly only from a quick glance at
patchwork.ozlabs.org) I see is that it's not possible to reliably filter
patches by directory name. (Or maybe I'm just to stupid to find the
right knob, I tried searching for "drivers/net/ehea" in the netdev
project, got a few hits, but e.g.
http://patchwork.ozlabs.org/patch/89837/ wasn't listed. My guess is that
the search only checks subject and commit log?)

For us I think this is a crucial function, because the imx patches are
usually sent to the linux-arm-kernel mailing list where most patches
don't touch the files we are responsible for.

The obvious way to work around that problem is to set up a private
instance of patchwork and use procmail filtering to only feed it with
the "interesting" patches. Alternatively we have to convince enough
people to use the same instance such that only a few patches are left
without a responsible person. These few could then be
marked/deleted/whatever by many people and won't be a big problem.

Actually I would prefer a public instance that collects all patches from
the linux-arm-kernel mailing list. So it would be really great to have
such a filter.

Do you consider that a good feature? Would it be possible to get that
online on patchwork.ozlabs.org and let that instance host a
linux-arm-kernel project? (Assuming someone is willing to implement it
first.) I have to talk to my boss first and check with him if I can
invest some time to implement that, but if someone else volunteers to do
it, that would be fine for me, too.

(I wrote "we" through the mail, actually I'm not the maintainer of imx,
I just did one round of collecting patches recently and I'm already
annoyed.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
