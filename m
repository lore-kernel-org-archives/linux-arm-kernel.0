From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 09:16:41 +0200
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
	<20110419190910.GQ31131@pengutronix.de>
	<alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
Message-ID: <20110420071641.GR31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 11:54:21PM +0200, Thomas Gleixner wrote:
> On Tue, 19 Apr 2011, Uwe Kleine-K?nig wrote:
> > > +1 for letting the core enable/disable and prepare/unprepare the parent
> > > clocks. I scanned the different arm clock implementations and they all
> > > do it, except the ones which do not implement parents at all.
> > Then the question is if all do handle parents in the same way. (i.e.
> > in enable do parent first, in disable do child first?)
> 
> That's not a question at all. Anything which does it the other way
> round is broken. Period.
I havn't checked, but I remember Jeremy not wanting to handle parents in
the generic part because he saw some differences.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
