From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 28 Apr 2014 15:48:29 +0200
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <20140428130639.GD2868@lvm>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
 <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
 <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
 <535E519B.7070101@redhat.com> <20140428130639.GD2868@lvm>
Message-ID: <535E5C2D.4090405@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 28/04/2014 15:06, Christoffer Dall ha scritto:
>> >
>> > Is Anup's patchset already on a branch?  If you send me a pointer to
>> > it I can look at that branch history and see what's best.
>> >
> I didn't merge it yet - need to make one final pass over it (likely
> later tonight).
>
> But this is the series:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-April/009061.html

Even better. :)

1) Catalin can apply "Add common header for PSCI related defines", or 
Ashwin can resend his series with the patch at the beginning.  Duplicate 
commits are fine, especially for seldom-modified files where they do not 
cause conflicts.

2) Send Anup's patchset as a pull request to both me and Catalin, 
relative to v3.16-rc1, both of us can apply it and Ashwin's series can 
be commit on top.

Paolo
