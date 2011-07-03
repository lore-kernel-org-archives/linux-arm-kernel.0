From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 3 Jul 2011 04:31:16 +0200
Subject: AT91: Fix pull requset
In-Reply-To: <20110701183313.GV11559@pengutronix.de>
References: <20110701065411.GD14408@game.jcrosoft.org>
	<201107011709.40359.arnd@arndb.de>
	<20110701183313.GV11559@pengutronix.de>
Message-ID: <20110703023116.GD28000@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:33 Fri 01 Jul     , Uwe Kleine-K?nig wrote:
> On Fri, Jul 01, 2011 at 05:09:40PM +0200, Arnd Bergmann wrote:
> > On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > HI Linus, Russell, Arnd
> > For every bug fix you commit, please check if it applies to older
> > kernels as well, and mark with 'Cc: stable at kernel.org' if so. Do you
> > want to update the changelog and send another pull request?
> Or alternatively (i.e. if you don't want to rewrite your tree) just
> writing to stable at kernel.org and indicating the upstream commit ids is
> usually OK, too.
> The other extreme is to point out the affected versions, e.g. by using 
> 
> 	Cc: stable at kernel.org [2.6.xy+]

I known and will have done if needed but those fixes are for this release only

Best Regards,
J.
