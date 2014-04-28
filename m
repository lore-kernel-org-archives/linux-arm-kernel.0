From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 28 Apr 2014 06:06:39 -0700
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <535E519B.7070101@redhat.com>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
 <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
 <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
 <535E519B.7070101@redhat.com>
Message-ID: <20140428130639.GD2868@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 03:03:23PM +0200, Paolo Bonzini wrote:
> Il 28/04/2014 14:23, Christoffer Dall ha scritto:
> >Are they inter-dependent?  I thought your patches depended on Anup's -
> >not the other way around?
> >
> >If my assumption is correct, I think we can make sure to send the pull
> >request to kvm/next early and ask Catalin to pull in kvm/next before
> >pulling your changes.
> >
> >I'm cc'ing both Catalin and Paolo here for their advice.
> 
> Is Anup's patchset already on a branch?  If you send me a pointer to
> it I can look at that branch history and see what's best.
> 
I didn't merge it yet - need to make one final pass over it (likely
later tonight).

But this is the series:
https://lists.cs.columbia.edu/pipermail/kvmarm/2014-April/009061.html

I believe Ashwin's patch set depends only on "ARM/ARM64: KVM: Add common
header for PSCI related defines".

Thanks,
-Christoffer
