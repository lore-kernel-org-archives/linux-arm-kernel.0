From: juri.lelli@arm.com (Juri Lelli)
Date: Mon, 7 Dec 2015 15:41:12 +0000
Subject: [RFC PATCH 0/8] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20151207131843.GP8644@n2100.arm.linux.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <20151207120244.GE14571@e106622-lin>
 <20151207121135.GN8644@n2100.arm.linux.org.uk>
 <20151207123654.GG14571@e106622-lin>
 <20151207131843.GP8644@n2100.arm.linux.org.uk>
Message-ID: <20151207154112.GK14571@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/15 13:18, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2015 at 12:36:54PM +0000, Juri Lelli wrote:
> > On 07/12/15 12:11, Russell King - ARM Linux wrote:
> > > It looks like the second patch doesn't yet have the backing from the DT
> > > people, which prevents the remainder of the patch set progressing.  That's
> > > the sticking point which needs to be resolved.
> > > 
> > 
> > Agreed. That is exactly the point for which I was seeking more feedback.
> > OTOH, 7/8 and 8/8 may potentially work without the DT bindings, as they
> > simply expose a sysfs attribute. If you, and others, see value in them,
> > I can easily put them at the top of the series and post a v2. Thoughts?
> 
> I've no idea, sorry.  When it comes to stuff like CPU level power
> management, the hardware I have is very limited in its capabilities
> (no support even for S2RAM.)  I've also never managed to get
> big.LITTLE working on my platforms that should support it.
> 

No problem. Thanks a lot for your feedback anyway.

> Eg, I gave up with the TC2 tile in Versatile Express.  I forget the
> details, but getting it booting was exceedingly difficult, and no one
> really seemed interested in helping.  So my TC2 tile is collecting
> dust while the CA9x4 tile lives in the platform - which is now part of
> the nightly build/boot test farm.
> 

I guess I could provide some support for the TC2 bits, if you didn't yet
give up completely on it :-). Please, don't hesitate to let me know,
even privately, about that.

Best,

- Juri
