From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 Jan 2012 23:24:56 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120109095839.GH21765@n2100.arm.linux.org.uk>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
 <20120109095839.GH21765@n2100.arm.linux.org.uk>
Message-ID: <20120109232456.GI30766@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 09:58:39AM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 08, 2012 at 08:49:53PM +0000, Mark Brown wrote:

> > That'd be extremely disappointing, especially given that there's some
> > bug fixes in there for updates going in this merge window without which
> > mainline is going to have problems on s3c64xx (mostly the GPIO stuff).

> Here we go again with sucky work practices.

> This sucky behaviour has been around for a long time, I've long since
> given up complaining about it as it's exactly like talking to a bloody
> brick wall.  People just continue mixing development and fixes together.

Actually in this case the issue is slightly different - the fixes are
mostly fixes for issues introduced by other development going in during
this merge window, what's gone wrong is that they've been applied to a
different branch to that which had the problem.  Still an issue of
course, just a different one.

That said there's also an issue if pure development gets delayed - it
makes it harder to do further work based on top of the work that got
delayed, especially if any cross tree issues come into play.

> Note: Linus _has_ taken a copy of linux-next (read the 3.2 release email),
> and _is_ checking whether development stuff was in linux-next prior to
> the merge window opening.  It would be very unwise to send new development
> which wasn't already there.

That's not an issue here, all the stuff that's being discussed is in
-next but not sent to the arm-soc tree.
