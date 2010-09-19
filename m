From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 19 Sep 2010 20:46:44 +0100
Subject: [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <201009180107.51664.rjw@sisk.pl>
References: <20100917121958.1dbb57af.akpm@linux-foundation.org>
	<4C93DC4E.5020506@ti.com> <201009180107.51664.rjw@sisk.pl>
Message-ID: <20100919194643.GB9871@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 18, 2010 at 01:07:51AM +0200, Rafael J. Wysocki wrote:
> On Friday, September 17, 2010, Nishanth Menon wrote:

> > there were a few OMAP followon patches from
> > http://marc.info/?l=linux-omap&m=128152135801634&w=2
> > which will actually use this for OMAP3 platform.

> Still, the $subject patch doesn't use it.  So perhaps add it in a separate patch?

By the same argument nothing in this patch causes the code to become
used so we may as well not include it at all :)

More seriously, looking at a lot of the questions that people are
raising it might make the review a bit easier if the patch were posted
in a series along with an initial user or two to provide some context
for the expected usage.
