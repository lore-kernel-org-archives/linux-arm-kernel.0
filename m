From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 15 Sep 2011 17:12:13 +0200
Subject: [PATCH 0/6] mc13783 cleanup
In-Reply-To: <201108250905.13168.philippe.retornaz@epfl.ch>
References: <20110824132740.GA28197@pengutronix.de>
	<201108250905.13168.philippe.retornaz@epfl.ch>
Message-ID: <20110915151213.GE32263@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Thu, Aug 25, 2011 at 09:05:12AM +0200, Philippe R?tornaz wrote:
> Le mercredi 24 ao?t 2011 15:27:40, Uwe Kleine-K?nig a ?crit :
> > Hello,
> > 
> > this series removes the long obsolte mc13783 API after fixing all
> > remaining users.
> 
> I posted a patch last month which was touching this MFD too.
> We will need to synchronize both patch. 
I applied Uwe's patchset now. Could you please sync your code and send me a
patchset that applies on top of:

git://git.infradead.org/users/sameo/mfd-2.6.git for-next

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
