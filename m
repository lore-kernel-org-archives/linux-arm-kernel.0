From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 18 Sep 2011 18:33:51 +0200
Subject: [PATCH 0/6] mc13783 cleanup
In-Reply-To: <20110915160321.GA29357@pengutronix.de>
References: <20110824132740.GA28197@pengutronix.de>
	<201108250905.13168.philippe.retornaz@epfl.ch>
	<20110915151213.GE32263@sortiz-mobl>
	<20110915160321.GA29357@pengutronix.de>
Message-ID: <20110918163351.GL32263@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Sep 15, 2011 at 06:03:21PM +0200, Uwe Kleine-K?nig wrote:
> Hi Samuel,
> 
> On Thu, Sep 15, 2011 at 05:12:13PM +0200, Samuel Ortiz wrote:
> > On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R?tornaz wrote:
> > > Le mercredi 24 ao?t 2011 15:27:40, Uwe Kleine-K?nig a ?crit :
> > > > Hello,
> > > > 
> > > > this series removes the long obsolte mc13783 API after fixing all
> > > > remaining users.
> > > 
> > > I posted a patch last month which was touching this MFD too.
> > > We will need to synchronize both patch. 
> > I applied Uwe's patchset now.
> Thanks.
> 
> >                               Could you please sync your code and send me a
> > patchset that applies on top of:
> > 
> > git://git.infradead.org/users/sameo/mfd-2.6.git for-next
> You can fetch the updated series from
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783
I merged this one on top of my for-next branch. My MFD tree temporary lives on
infradead:

git://git.infradead.org/users/sameo/mfd-2.6.git

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
