From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Jul 2013 01:17:53 +0100
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
Message-ID: <20130701001752.GL3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 10:01:30AM +1000, Dave Airlie wrote:
> OMG I'm working in a subsystem where stuff is being developed, with only
> a few resources! I know my full time job isn't maintaining a 500,000
> line subsystem,
> and the sub maintainers and developers do a great job refactoring
> where required.
> 
> lots of other driver authors have made substantial changes to the drm core as
> they've written drivers, you spot one bit of refactoring and its a
> major shortcoming
> of the entire subsystem and development community.
> 
> how about instead of writing:
> "However, at least I've taken the time to _think_ about what I'm doing
> and realise that there _is_ scope here for the DRM core to improve,
> rather than burying this stuff deep inside my driver like everyone else
> has.  That's no reason to penalise patches from the "good guys" who think"
> 
> you go with
> "I noticed this piece of functionality could be refactored, here is a
> patch adding them to
> the core, does anyone think its a good idea?"
> 
> As Daniel pointed out every driver submitted has refactored things,
> even exynos did a
> lot of work to be the first ARM driver we shipped, the DRM core
> doesn't write itself and
> I fully expect driver authors to be the ones that tell me what needs
> refactoring, since
> they are on the pointy end, but to state that you are the only person
> ever to think about
> things is frankly being a dick.
> 
> Lets try for less dick, and more productive in future.

And you can stick your dick back where you got it from David.  Really,
your response is totally uncalled for.

Let's try realising that I only have very limited time to put into this
and unlike the other submitters who have been _paid_ to get their code
sorted, this is being done purely for free - which means it's really
low priority.  As you should already realise because I've stated already
that I *really* don't care whether it gets into mainline or not.

I am *NOT* planning on spending any time on this during the next week
as I have *paid* work to do, and probably not next weekend nor the
following week either.  So the next time that I'm likely to do anything
on this is in a fortnight or longer.

If you want stuff to be refactored in DRM, you need to find someone
with more time to do it.

And before you continue making a mountain out of a molehill, as you
seem to like doing, the "let's make it a core thing" is REALLY BLOODY
SIMPLE.  All it takes is for the header file to go into include/drm.
It's now available to anyone who wants to use that - and all that's
left is to sort out all those drivers *WHICH I CANT TEST* to use
that stuff.

And, frankly, when I was going to post this latest RFC, I gave serious
consideration to quite simply not posting it to dri-devel and copying
you or any other person listed as a maintainer for DRM, and only posting
it to the people interested in it on the ARM side, because I'd already
given up hope of it ever being merged into mainline.

Your totally over the top and rediculous response just confirms that.

Further postings will now omit you and dri-devel.
