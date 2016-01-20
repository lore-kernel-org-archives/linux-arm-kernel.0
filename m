From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 20 Jan 2016 10:22:37 +0000
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20160119211049.GX6588@sirena.org.uk>
References: <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
 <20160119112323.GB8573@e106622-lin>
 <20160119142933.GF8573@e106622-lin> <569E92FF.4000006@linaro.org>
 <20160119211049.GX6588@sirena.org.uk>
Message-ID: <20160120102237.GN8573@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 21:10, Mark Brown wrote:
> On Tue, Jan 19, 2016 at 11:48:15AM -0800, Steve Muckle wrote:
> > On 01/19/2016 06:29 AM, Juri Lelli wrote:
> 
> > > I'm generally seeing ~1sec increase in boot time for 1 and practically
> > > no difference for 2 (even after having added patches that provide
> > > runtime performance improvements).
> 
> > One second is considerable IMO. Aside from the general desire to have
> > shorter boot times on any platform there are environments like
> > automotive where boot time is critical.
> 
> Yeah, definitely.  Is this actually blocking boot and if so can we
> arrange to do this in parallel with other activity (with likely knock on
> effects on reproducibility...)?

No, this goes in parallel. That's also showed by the fact that the
benchmarking thing itself usually takes more that 1 sec, but it seems to
impact for that amount of time only.
