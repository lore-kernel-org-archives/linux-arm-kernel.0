From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 Aug 2010 16:11:04 +0900
Subject: Merge request of s5pc210 universal board.
In-Reply-To: <AANLkTi=oKyiVtMoZH7czYr5LQoLOMtZtG63RwXay8c2k@mail.gmail.com>
References: <AANLkTik1bxh8zfCuKV5UOcYyJW-QbGhT5PYen4MzE1R+@mail.gmail.com>
	<006d01cb3521$e4e559e0$aeb00da0$%kim@samsung.com>
	<AANLkTinQ1mP2e5DA0J_GyWn32EAckgT3b=Ar6gHzDijX@mail.gmail.com>
	<AANLkTi=oKyiVtMoZH7czYr5LQoLOMtZtG63RwXay8c2k@mail.gmail.com>
Message-ID: <008601cb3536$8b42ad60$a1c80820$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Fri, Aug 6, 2010 at 1:47 PM, Kyungmin Park <kmpark@infradead.org>
wrote:
> > On Fri, Aug 6, 2010 at 1:43 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> >> Kyungmin Park wrote:
> >>>
> >>> Dear all,
> >>>
> >> Hi,
> >>
> >>> Now I checked the next-v310 tree and know that only LSI required codes
> >>> are merged.
> >>> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
> >>> samsung.git;a=shortlog;h=refs/heads/next-s5pv310
> >>>
> >>> I can't find any reason to omit the universal board file. It's posted
> >>> before merge window and no difference with LSI SMDK board at current
> >>> status.
> >>
> >> Please answer my concern..I already replied to you about this.
> >>
> >>
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/022087.html
> >> ---
> >>> >> +config MACH_UNIVERSAL
> >>> >
> >>> > As I still asking, do you _really_ want to use 'UNIVERSAL' as the
> >>> > board(machine) name?
> >>>
> >>> Yes, it's called 'universal' and it's really universal board at here.
> >>> I don't confuse the engineer who develop this board.
> >>> Maybe your engineers saw and hear the brief description about
universal
> >> board.
> >>>
> >> Actually, I know that. But there are S5PC100, S5PC110 universal board
> >> also...
> >> So I asked to you that you _really_ want to use 'universal' here...and
I'm
> >> still concerning.
> >
> > No comment means "Of course want to merge it". thank you for your
> > concerning. but I can handle it.
> 
Hi,

> After discuss with Mr. Kim. I changed to use non-generic name to
universal_c210.
> 
Thanks for your understanding...IMHO, 'MACH_UNIVERSAL_C210' is quite long...
If you don't mind, how about 'MACH_UNI_C210' or 'MACH_UNIC210'...but it
depends on your decision.

> Then do you resend the patch? or can you handle it by yourself?
> 
I will apply this with changing it.

> To Russell.
> Sorry for bothering you.
> Can you change the registered universal to universal_c210?
> universal_c210          MACH_UNIVERSAL_C210     UNIVERSAL_C210
> 
> Thank you,
> Kyungmin Park
> >
> >> ---
> >>
> >>> I try to support our board at mainline kernel but it seems to make a
> >>> difficult with unknown commit criteria of LSI.
> >>>
> >>


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
