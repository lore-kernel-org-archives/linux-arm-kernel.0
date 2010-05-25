From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 25 May 2010 12:57:30 +0200
Subject: [PATCH 05/16] arm/mx2/pca100: add #ifdef to fix compiler warning
In-Reply-To: <20100525090431.GA16160@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100525000656.GA11887@pengutronix.de>
	<20100525090431.GA16160@pengutronix.de>
Message-ID: <20100525105730.GD25521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 11:04:31AM +0200, Uwe Kleine-K?nig wrote:

> ah, OK, your patch looks more complete.  I dropped my patch and took
> your's instead.  While at it I took "[PATCH] pcm037: fix build warning",
> too.

Hmm, your patches are for 2.6.36; I think these build-fixes should go to
2.6.35 (if Sascha's pull request for mxc-master will be accepted, that is).
Otherwise, OK.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100525/6c7d973c/attachment.sig>
