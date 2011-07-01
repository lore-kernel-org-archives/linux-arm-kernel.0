From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Jul 2011 20:33:14 +0200
Subject: AT91: Fix pull requset
In-Reply-To: <201107011709.40359.arnd@arndb.de>
References: <20110701065411.GD14408@game.jcrosoft.org>
	<201107011709.40359.arnd@arndb.de>
Message-ID: <20110701183313.GV11559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 05:09:40PM +0200, Arnd Bergmann wrote:
> On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > HI Linus, Russell, Arnd
> For every bug fix you commit, please check if it applies to older
> kernels as well, and mark with 'Cc: stable at kernel.org' if so. Do you
> want to update the changelog and send another pull request?
Or alternatively (i.e. if you don't want to rewrite your tree) just
writing to stable at kernel.org and indicating the upstream commit ids is
usually OK, too.
The other extreme is to point out the affected versions, e.g. by using 

	Cc: stable at kernel.org [2.6.xy+]

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
