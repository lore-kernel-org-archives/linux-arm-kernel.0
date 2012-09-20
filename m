From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 20 Sep 2012 13:37:45 +0100
Subject: [PATCH v2 07/13] misc: Versatile Express config infrastructure
In-Reply-To: <201209201236.28157.arnd@arndb.de>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <201209191308.43676.arnd@arndb.de> <1348142814.11116.113.camel@hornet>
 <201209201236.28157.arnd@arndb.de>
Message-ID: <1348144665.11116.114.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 13:36 +0100, Arnd Bergmann wrote:
> On Thursday 20 September 2012, Pawel Moll wrote:
> > > For now, I'd suggest you put this driver into drivers/mfd together
> > > with the other part from your patch 8.
> > 
> > Do you mean - merge it into one file? I'd rather avoid that - the time
> > will come (and probably sooner than I would hope) when there will be a
> > new VE generation with some other "config bridge" instead of the
> > sysregs.
> 
> No, just leave it at two files. We have a number of examples of mfd drivers
> that have a common part and e.g. i2c and spi based files as back-ends.
> For now, you'd just build both files together.

Sure thing, thanks!

Pawe?
