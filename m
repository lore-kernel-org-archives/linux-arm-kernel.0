From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 10 Dec 2011 10:55:28 +0100
Subject: [PATCH] ARM: only show modules in the memory layout for MODULES=y
In-Reply-To: <alpine.LFD.2.02.1112091813130.2907@xanadu.home>
References: <1323466291-9679-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <alpine.LFD.2.02.1112091813130.2907@xanadu.home>
Message-ID: <20111210095528.GW4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 06:14:49PM -0500, Nicolas Pitre wrote:
> On Fri, 9 Dec 2011, Uwe Kleine-K?nig wrote:
> 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> If compilation breaks without this with CONFIG_MODULES=n then please say 
> so in the commit log.
It doesn't (at least for me), it just suppresses the irritating modules
line. Will add that to the commit log for an eventual resend.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
