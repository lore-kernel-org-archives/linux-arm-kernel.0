From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Wed, 25 Aug 2010 16:40:40 +0200
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <201008251555.53653.arnd@arndb.de>
References: <4C61EE55.5030506@codeaurora.org>
	<201008251414.16411.arnd@arndb.de>
	<20100825125451.GH2153@osiris.boeblingen.de.ibm.com>
	<201008251555.53653.arnd@arndb.de>
Message-ID: <20100825144040.GI2153@osiris.boeblingen.de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 03:55:53PM +0200, Arnd Bergmann wrote:
> On Wednesday 25 August 2010, Heiko Carstens wrote:
> > > I think it would be easier to remove the config option entirely on s390
> > > and just always warn. As I said earlier in this thread, I generally
> > > don't think this particular warning is more important than a lot of
> > > the other ones that we don't turn into errors.
> > 
> > I disagree: a default kernel build should compile without the noise of
> > tens of false positive warnings.
> > Nobody would look at new warnings and fix possible bugs.
> > That's why I want to have an option to turn the warnings off (default).
> > 
> > Or are you volunteering to "fix" all the false positives? :)
> 
> If you don't want to see the warnings, then just remove the strict checks.
> We already concluded that there is little value in them on s390 since it only
> shows false postives.
> 
> Maybe the easiest way would be to rename the option on s390 and move all
> the other ones into a common place.

Yes, feel free to do that.
