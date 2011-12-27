From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Tue, 27 Dec 2011 10:35:09 +0900
Subject: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <08e401ccc434$841e6630$8c5b3290$%kim@samsung.com>
References: <1324624169-16102-1-git-send-email-riverful.kim@samsung.com>
 <088901ccc1dd$deea1e00$9cbe5a00$%kim@samsung.com>
 <CAH9JG2WEcA1BwWq+uovrax5bWvuXaYsGky8D9txymXta7GY8TQ@mail.gmail.com>
 <08e101ccc42f$c3a10b00$4ae32100$%kim@samsung.com>
 <CAH9JG2VnchqHbhmDyqhqm_oT+oL5zkbbDonT1a7-5+9z+3wVXw@mail.gmail.com>
 <08e401ccc434$841e6630$8c5b3290$%kim@samsung.com>
Message-ID: <CAH9JG2VgU3Uuq48F-BQ4vtfkC2bn8FrF54gRq51cE8Ay1+11LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> On 12/27/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > Kyungmin Park wrote:
>> >>
>> >> On 12/24/11, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> >> > HeungJun, Kim wrote:
>> >> >>
>> >> >> This patch adds Samsung Mobile TRATS board support.
>> >> >>
>> >> >> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
>> >> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> >> >> ---
>> >> >>  arch/arm/mach-exynos/Kconfig       |   11 ++
>> >> >>  arch/arm/mach-exynos/Makefile      |    1 +
>> >> >>  arch/arm/mach-exynos/board-trats.c |  340
>> >> >> ++++++++++++++++++++++++++++++++++++
>> >> >>  3 files changed, 352 insertions(+), 0 deletions(-)
>> >> >>  create mode 100644 arch/arm/mach-exynos/board-trats.c
>> >> >>
>> >> >
>> >> > If this is for v3.3, unfortunately, it's a little late to add board
>> file
>> >> and
>> >> > since many things have changed I don't want to cause the conflicts
>> with
>> >> > others now.
>> >> >
>> >> > BTW, why is the name board-xxx not mach-xxx like others?
>> >>
>> >> It's mentioned several times,
>> >> How do you talk with other when talk about the smdk?
>> >> "I'm using the smdk machine and it's based on smdk machine?"
>> >> As board is more proper word and it's easy to know when find the board
>> >> at source code.
>> >> So hope to use the board if it's not big deal.
>> >>
>> > Yes, we say 'SMDK board blah blah' so it can be no big deal, but I don't
>> > want to make a confusion between CONFIG_MACH_XXX and mach-xxx.c yet even
>> > though there is a similar situation of arch/arm/mach-xxx/ directory and
>> > CONFIG_ARCH_XXX. In addition, the machine_is_xxx() is used to
>> distinguish
>> > board in the kernel.
>> >
>> > Anyway, I think, if to use board-xxx.c is required, we can change it all
>> at
>> > once and let me think again.
>>
>> Don't think, use the current way.
>
> You seem not to have the common courtesy to discuss something here.

I also have same opinion on you. Discussion(?) with you is meaningless
and don't see any progress.

BR
