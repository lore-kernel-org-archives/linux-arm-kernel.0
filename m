From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Oct 2011 19:56:11 +0200
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
	<005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
Message-ID: <201110071956.12034.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011, Kukjin Kim wrote:
> Mark Brown wrote:
> > 
> > On Sun, Oct 02, 2011 at 06:25:36PM +0900, Kukjin Kim wrote:
> > 
> > >       gpio/samsung: gpio-samsung.c to support Samsung GPIOs
> > 
> > As I reported the other day this change breaks the boot early on on the
> > Cragganmore S3C6410 based systems (I've not actually fired up my
> > SMDK6410 but I suspect it may have issues too).  I did make some brief
> > attempts to debug but as there's no console output at all and the diff
> > is rather large it's not easy to see what's gone wrong.
> 
> Hmm, I thought it has no problem when I saw Thomas Abraham's 'serial:
> samsung' patches because he said it works fine with my for-next plus his
> patches on SMDK6410...Anyway, I need to sort it out.
> 
> Arnd, please hold this on, will request again soon.

Any update on this?

Note that in general, I would prefer to get more separate pull
requests for the individual feature branches that you use internally
than having it all in one devel branch.

Time is running out before the merge window, so I'm not asking you
to change it again. I will pull it when you send it, but if you
have trouble with some specific parts of this, you can also send
me pull requests for the parts that are good.

	Arnd
