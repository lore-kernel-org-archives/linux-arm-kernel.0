From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Aug 2011 09:57:19 +0200
Subject: [PATCH 0/6] mc13783 cleanup
In-Reply-To: <201108250905.13168.philippe.retornaz@epfl.ch>
References: <20110824132740.GA28197@pengutronix.de>
	<201108250905.13168.philippe.retornaz@epfl.ch>
Message-ID: <20110825075719.GL16557@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R?tornaz wrote:
> Le mercredi 24 ao?t 2011 15:27:40, Uwe Kleine-K?nig a ?crit :
> > Hello,
> > 
> > this series removes the long obsolte mc13783 API after fixing all
> > remaining users.
> 
> I posted a patch last month which was touching this MFD too.
> We will need to synchronize both patch. 
Ah right. At one point I remembered your patch set because I wondered
that ..._USE_REGULATOR is still used.

Assuming all involved people are OK with both patch sets I can do the
merge of both patch sets.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
