From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Sep 2011 18:03:21 +0200
Subject: [PATCH 0/6] mc13783 cleanup
In-Reply-To: <20110915151213.GE32263@sortiz-mobl>
References: <20110824132740.GA28197@pengutronix.de>
	<201108250905.13168.philippe.retornaz@epfl.ch>
	<20110915151213.GE32263@sortiz-mobl>
Message-ID: <20110915160321.GA29357@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Thu, Sep 15, 2011 at 05:12:13PM +0200, Samuel Ortiz wrote:
> On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R?tornaz wrote:
> > Le mercredi 24 ao?t 2011 15:27:40, Uwe Kleine-K?nig a ?crit :
> > > Hello,
> > > 
> > > this series removes the long obsolte mc13783 API after fixing all
> > > remaining users.
> > 
> > I posted a patch last month which was touching this MFD too.
> > We will need to synchronize both patch. 
> I applied Uwe's patchset now.
Thanks.

>                               Could you please sync your code and send me a
> patchset that applies on top of:
> 
> git://git.infradead.org/users/sameo/mfd-2.6.git for-next
You can fetch the updated series from

	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783

I also included the last patch that Sascha commented with:

	Please ping once the rest is merged.

This is OK as I'm currently substituting Sascha for imx maintainer
duties while he is on vacation. Merging the above branch into the
current imx/for-next branch yields a merge conflict in
drivers/rtc/rtc-twl.c which is only touched on your side and in Linus'
tree below imx/for-next.

I guess you can drop 54d96ef785b5 as it is the same as dec35d19c4 +
34d623d.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
