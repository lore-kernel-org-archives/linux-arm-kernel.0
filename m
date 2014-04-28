From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 28 Apr 2014 15:03:23 +0200
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>	<1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>	<CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>	<CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
 <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
Message-ID: <535E519B.7070101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 28/04/2014 14:23, Christoffer Dall ha scritto:
> Are they inter-dependent?  I thought your patches depended on Anup's -
> not the other way around?
>
> If my assumption is correct, I think we can make sure to send the pull
> request to kvm/next early and ask Catalin to pull in kvm/next before
> pulling your changes.
>
> I'm cc'ing both Catalin and Paolo here for their advice.

Is Anup's patchset already on a branch?  If you send me a pointer to it 
I can look at that branch history and see what's best.

Paolo
