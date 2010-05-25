From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 May 2010 20:36:35 +0200
Subject: [PATCH 05/16] arm/mx2/pca100: add #ifdef to fix compiler warning
In-Reply-To: <20100525105730.GD25521@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100525000656.GA11887@pengutronix.de>
	<20100525090431.GA16160@pengutronix.de>
	<20100525105730.GD25521@pengutronix.de>
Message-ID: <20100525183635.GA17633@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 12:57:30PM +0200, Wolfram Sang wrote:
> On Tue, May 25, 2010 at 11:04:31AM +0200, Uwe Kleine-K?nig wrote:
> 
> > ah, OK, your patch looks more complete.  I dropped my patch and took
> > your's instead.  While at it I took "[PATCH] pcm037: fix build warning",
> > too.
> 
> Hmm, your patches are for 2.6.36; I think these build-fixes should go to
> 2.6.35 (if Sascha's pull request for mxc-master will be accepted, that is).
> Otherwise, OK.
They only fix warnings but shouldn't make any difference for the
generated code.  So I think 2.6.36 is OK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
