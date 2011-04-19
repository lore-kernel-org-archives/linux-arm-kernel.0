From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Apr 2011 20:40:51 +0200
Subject: [PATCH] ARM: at91: AT91CAP9 has a macb device
In-Reply-To: <20110419154941.GC19199@game.jcrosoft.org>
References: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110419154941.GC19199@game.jcrosoft.org>
Message-ID: <20110419184050.GP31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 05:49:41PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:21 Tue 19 Apr     , Uwe Kleine-K?nig wrote:
> > commit
> > 
> > 	ee621dd (net: atmel_macb Kconfig: remove long dependency line)
> > 
> > replaced a list of several explicit machines in the dependencies of MACB by
> > a single symbol that is selected by the respective machines. ee621dd missed
> > to let ARCH_AT91CAP9 select HAVE_NET_MACB though which is fixed here.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
I don't understand why you reply with a S-o-b. Does that mean you took
the patch somehow? If not, I think an Ack would be more appropriate.
With path should this patch go? Patch system?

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
