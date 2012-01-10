From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jan 2012 18:31:23 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120110090635.GT21765@n2100.arm.linux.org.uk>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
 <01a301ccce6f$9bb51790$d31f46b0$%kim@samsung.com>
 <201201091556.34817.arnd@arndb.de>
 <20120109161152.GA2974@opensource.wolfsonmicro.com>
 <20120110090635.GT21765@n2100.arm.linux.org.uk>
Message-ID: <20120110183123.GD7164@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 09:06:35AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 09, 2012 at 08:11:54AM -0800, Mark Brown wrote:

> > This really is very disappointing.

> No it isn't.

I think we're talking at cross purposes here - I'm saying that this
whole situation is disappointing, not a specific decision.

> What is really disappointing is the lack of responsive maintainers for the
> Samsung stuff.  It took _two_ bloody months to get the Samsung platforms

This is pretty much what I'm saying is disappointing - in this case the
whole fact that we're not managing to get stuff actually merged.  It's
very frustrating that we're ending up in a situation where getting
things applied to the maintainer's tree and into -next (which is usually
the end of what you need to do as a patch submitter) isn't enough to
actually get the changes pushed upstream.

> The only reason something happened was because I stuck a #error into
> the Samsung code in linux-next and people started reporting that Samsung
> had broken.

Yeah, me included.  Like I said I'd probably have sent a fix if I'd been
able to figure out what the changes the error referred to were.

> The alternative was basically Samsung ending up like shmobile is today.
> Maybe that's what should have happened to save folk like Arnd such a
> horrible job now.

So, is there anything that people like me who are contributing to rather
than maintaining things can do to help here beyond chasing maintainers?

Generally my process is roughly to monitor what goes into -next and
chase people if things don't make it in there but that's not working
well here as things are appearing in -next.
