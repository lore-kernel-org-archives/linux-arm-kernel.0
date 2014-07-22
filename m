From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jul 2014 17:29:24 +0100
Subject: [PATCH v2] bus: ARM CCN PMU driver
In-Reply-To: <CAOesGMijrD6SxAyjvQptmAB8swqcvXNkiVS_nRCtUVtX2vYUFQ@mail.gmail.com>
References: <1405091188-31754-1-git-send-email-pawel.moll@arm.com>
 <1406023886.25343.48.camel@hornet>
 <CAOesGMijrD6SxAyjvQptmAB8swqcvXNkiVS_nRCtUVtX2vYUFQ@mail.gmail.com>
Message-ID: <1406046564.25343.74.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 09:08 -0700, Olof Johansson wrote:
> On Tue, Jul 22, 2014 at 3:11 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > Hi Arnd, Kevin, Olof,
> >
> > On Fri, 2014-07-11 at 16:06 +0100, Pawel Moll wrote:
> >> Driver providing perf backend for ARM Cache Coherent Network
> >> interconnect. Supports counting all hardware events and crosspoint
> >> watchpoints.
> >>
> >> Currently works with CCN-504 only, although there should be
> >> no changes required for CCN-508 (just impossible to test it now).
> >>
> >> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> >
> > Would you consider taking this through arm-soc tree? There isn't
> > anything in MAINTAINERS, but I vaguely remember Arnd proposing this
> > directory in the first place...
> 
> Yeah, drivers/bus lacks an owner and we've normally been the ones
> merging them. Please send a fresh version of the patch over.

I've just rebased in on top of v3.16-rc6 and there's no change
whatsoever (which is a good thing, I guess), so I can send v3, but the
"changes since v2" will say "nothing" :-)

Thanks!

Pawel
