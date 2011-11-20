From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Nov 2011 20:27:19 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com> <20111118145635.GB17991@mudshark.cambridge.arm.com>
 <CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1111192019200.30133@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, 19 Nov 2011, Ming Lei wrote:

> On Fri, Nov 18, 2011 at 10:56 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> > Ming Lei - can you take this into your patch series please?
> 
> Yes, I have made omap4 pmu work already with Benoit's patch,
> and if no one has objections on other patches(5/7, 6/7, 7/7), I
> can post out the next version for -next tree.
> 
> > Then we'll have:
> >
> > ? ? ? ?- The two perf patches in my tree
> > ? ? ? ?- The hwmod fix in Tony's tree (pending pull)
> > ? ? ? ?- Your patches plus this one for hooking everything together
> >
> > The sooner we can push these into -next, the better.

The OMAP-specific parts should be queued up in my/Beno?t's/Tony's trees, 
rather than placed directly into -next.  Otherwise they are likely to 
generate merge conflicts with other OMAP changes that we may generate.

So I'd suggest splitting patches 1-3 off into a separate series that Will 
can pass on to -next if he wishes.


- Paul
