From: olof@lixom.net (Olof Johansson)
Date: Sat, 26 May 2012 01:46:38 -0700
Subject: [GIT PULL] Veratile Express DT updates for v3.5
In-Reply-To: <1337589524.2262.4.camel@hornet>
References: <1337589524.2262.4.camel@hornet>
Message-ID: <CAOesGMiLYy=_a+=Km8pswoTbCuHsu-tVwP5mH2fd1oCXM_83cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Mon, May 21, 2012 at 1:38 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Arnd, Ofof,
>
> Could you, please, pull this micro-updated for Versatile Express?
> These are mostly DT changes related to A!5's architected timers and
> VGIC. I have dropped the earlyprintk/uncompress patch for now because
> Russell didn't like it.
>
> Much more to come for 3.6 :-)
>
> Thanks and apologies about short notice!

Since this is the first time you're late with a pull request, and the
branch is small, I'll cut you some slack. However, next time we get a
pull request like this after the merge window is open, I will punt it
until the next release.

So, I'll queue this up in late/soc and send it up sometime next week.
If the merge window closes early this means it _could_ miss it, but
hopefully not.


To avoid this from happening next time, please make sure the pull
requests reach us by -rc6 or -rc7 time frame.


Thanks,

-Olof
