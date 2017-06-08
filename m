From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 8 Jun 2017 10:33:27 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170608082417.GA2244@mai>
References: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai>
 <20170607231715.ns2vcxza2eexnzjs@piout.net>
 <20170608074236.62924f01@bbrezillon> <20170608074446.GM2345@mai>
 <20170608075900.i554dgbh3p5sq5ml@piout.net>
 <20170608082417.GA2244@mai>
Message-ID: <20170608103327.0fbc7bb5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jun 2017 10:24:17 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On Thu, Jun 08, 2017 at 09:59:01AM +0200, Alexandre Belloni wrote:
> > On 08/06/2017 at 09:44:46 +0200, Daniel Lezcano wrote:  
> > > 
> > > +Mark Rutland, +Rob Herring
> > > 
> > > 
> > > Alexandre, Boris, have a look at https://www.spinics.net/lists/arm-kernel/msg572652.html
> > > 
> > > That will tell you the story.
> > >   
> > 
> > Ok, so is the solution putting the driver back in mach-at91 were we can
> > do whatever we want like mach-omap2 is doing?  
> 
> No. And putting a driver in mach-<whatever> does not give the permission to do
> whatever you want. I won't tell you how OSS works, but moving code around or
> using another tree to circumvent a code review is just the best way to upset
> maintainers in general and hurt your karma.
> 
> That said, I think you misunderstood my comment (or I was not clear). In the
> discussion given in the link above, I am in favor, somehow, to distinguish
> clockevent and clocksource to solve exactly what you are facing.
> 
> Rob Herring told me it could be acceptable to have a property to tell if it is
> a clockevent or a clocksource.
> 
> Mark Rutland disagreed on this.
> 
> I was alone in the discussion, no consensus have been found.

Indeed, I misunderstood your point.

> 
> Now, you have a particular use case and I would like to resurrect the
> discussion in order to find a solution which can apply to all DT drivers.

Ok, glad to see we're on the same page.

Mark, can we re-open the discussion?

Thanks,

Boris
