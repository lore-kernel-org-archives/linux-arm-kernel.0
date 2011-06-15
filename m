From: peter.fordham@gmail.com (Peter Fordham)
Date: Wed, 15 Jun 2011 12:49:43 -0700
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <201106152136.23971.arnd@arndb.de>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
	<20110615190945.GA2518@pulham.picochip.com>
	<201106152136.23971.arnd@arndb.de>
Message-ID: <BANLkTi=_DDxRqhqi=9Me6gWmm2h3wb5Zng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 June 2011 12:36, Arnd Bergmann <arnd@arndb.de> wrote:
> Let's first wait until the generic watchdog framework gets merged and
> the drivers are converted. After that is in, we can discuss further changes.

That seems logical and reasonable. Are we saying no changes to watchdog
drivers in general until this is done? because I have other patches
for this driver
that among other things actually make it work properly. As it stands today
the timeout calculations are broken which results in random reboots.

The framework patch was submitted 3.5 months ago and isn't in yet. Is it held up
on something? I don't see any negative comments.

> I highly doubt that making an incompatible API change benefits anyone here,
> but it certainly shouldn't be done for a single driver that is separate from
> the framework.

Not to be a pedant but, this doesn't change the API at all.

-Pete
