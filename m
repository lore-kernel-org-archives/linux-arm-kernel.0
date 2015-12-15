From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Dec 2015 15:57:37 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151215154651.GK16007@e106622-lin>
References: <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
 <20151215133951.GY5727@sirena.org.uk>
 <20151215140135.GI31299@leverpostej>
 <20151215150813.GZ5727@sirena.org.uk>
 <20151215153218.GA7228@leverpostej>
 <20151215154651.GK16007@e106622-lin>
Message-ID: <20151215155737.GB7619@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 03:46:51PM +0000, Juri Lelli wrote:
> On 15/12/15 15:32, Mark Rutland wrote:
> > On Tue, Dec 15, 2015 at 03:08:13PM +0000, Mark Brown wrote:
> > > My expectation is that we just need good enough, not perfect, and that
> > > seems to match what Juri is saying about the expectation that most of
> > > the fine tuning is done via other knobs.
> > 
> > My expectation is that if a ballpark figure is good enough, it should be
> > possible to implement something trivial like bogomips / loop_per_jiffy
> > calculation.
> > 
> 
> I didn't really followed that, so I might be wrong here, but isn't
> already happened a discussion about how we want/like to stop exposing
> bogomips info or rely on it for anything but in kernel delay loops?

I meant that we could have a benchmark of that level of complexity,
rather than those specific values.

Mark.
