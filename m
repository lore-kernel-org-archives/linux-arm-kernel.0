From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 24 Feb 2015 20:42:16 +0530
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150224145407.GA26609@gmail.com>
References: <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
 <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
 <20150220132220.GB28882@gmail.com>
 <CAKohpokEV7EatQROgzQBWPRPFEn8OsMo5EHa+q1FMwBESwiU3w@mail.gmail.com>
 <20150220140432.GA31928@gmail.com>
 <CAKohponv=aR7Ae_z7zbnDDeJ-mCFwdxB3wR-O4boBeMKYdUJLA@mail.gmail.com>
 <20150223163706.GA12551@gmail.com> <54EC5C69.2010909@linaro.org>
 <20150224145407.GA26609@gmail.com>
Message-ID: <CAKohpomGa7+rh1a0=H6V=i5Qfr5N9i3gmPW+V=xQnmfQTZceTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2015 at 20:24, Ingo Molnar <mingo@kernel.org> wrote:
> And here's the diffstat:

Sorry for not providing that :(

>  arch/arm/common/bL_switcher.c |    8 +--
>  include/linux/clockchips.h    |   48 ++++++++++++------
>  kernel/time/clockevents.c     |  109 ++++++++++++++++++++++++------------------
>  kernel/time/tick-broadcast.c  |   22 ++++----
>  kernel/time/tick-common.c     |    9 +--
>  kernel/time/tick-internal.h   |    1
>  kernel/time/tick-oneshot.c    |    6 +-
>  kernel/time/timer_list.c      |   16 +++---
>  8 files changed, 129 insertions(+), 90 deletions(-)
>
> Not too bad I think.

Thanks, I will send the patches now after some rework.
