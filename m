From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 7 Oct 2011 20:14:43 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <201110071956.12034.arnd@arndb.de>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
	<201110071956.12034.arnd@arndb.de>
Message-ID: <20111007191443.GA12004@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 07:56:11PM +0200, Arnd Bergmann wrote:
> On Monday 03 October 2011, Kukjin Kim wrote:
> > Mark Brown wrote:

> > > As I reported the other day this change breaks the boot early on on the
> > > Cragganmore S3C6410 based systems (I've not actually fired up my
> > > SMDK6410 but I suspect it may have issues too).  I did make some brief

> > Hmm, I thought it has no problem when I saw Thomas Abraham's 'serial:
> > samsung' patches because he said it works fine with my for-next plus his
> > patches on SMDK6410...Anyway, I need to sort it out.

> > Arnd, please hold this on, will request again soon.

> Any update on this?

We've got a lot closer to working out what's wrong (and got useful
logging) but not nailed it down yet.  Kukjin has confirmed that he can
see what's likely the same issue on his systems.  My suggestion is that
we go ahead with the pull request for now and then fix incrementally,
there's a relatively small set of systems affected.  If it gets to more
than a couple of -rcs we know which patches are problematic and so can
always revert.
