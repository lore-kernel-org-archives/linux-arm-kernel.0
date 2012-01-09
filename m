From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 09:58:39 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120108204953.GA20043@sirena.org.uk>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
Message-ID: <20120109095839.GH21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 08:49:53PM +0000, Mark Brown wrote:
> On Fri, Jan 06, 2012 at 01:58:29PM -0800, Olof Johansson wrote:
> 
> > > Please pull Samsung devel for v3.3 from:
> > > ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > > next-samsung-devel-samsung
> 
> > Thanks. I've pulled this into late/devel, based on earlier email from
> > Arnd we might end up sending this in towards the end of the merge
> > window, but there's also a chance it will wait for 3.4.
> 
> That'd be extremely disappointing, especially given that there's some
> bug fixes in there for updates going in this merge window without which
> mainline is going to have problems on s3c64xx (mostly the GPIO stuff).

Here we go again with sucky work practices.

This sucky behaviour has been around for a long time, I've long since
given up complaining about it as it's exactly like talking to a bloody
brick wall.  People just continue mixing development and fixes together.

They then wonder why their fixes don't make it into mainline in a timely
fashion.

Maybe delaying the whole lot will make people change their behaviour:
it's a behaviour that needs to change at the submitters end.  There's
nothing which Olof or Arnd can reasonably do to expedite the fixes.

So, please direct your complaints to the submitter for not having a
work practice which ensures that fixes receive a higher submission
priority.

Note: Linus _has_ taken a copy of linux-next (read the 3.2 release email),
and _is_ checking whether development stuff was in linux-next prior to
the merge window opening.  It would be very unwise to send new development
which wasn't already there.
