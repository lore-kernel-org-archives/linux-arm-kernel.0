From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 6 Aug 2010 13:47:07 +0900
Subject: Merge request of s5pc210 universal board.
In-Reply-To: <006d01cb3521$e4e559e0$aeb00da0$%kim@samsung.com>
References: <AANLkTik1bxh8zfCuKV5UOcYyJW-QbGhT5PYen4MzE1R+@mail.gmail.com>
	<006d01cb3521$e4e559e0$aeb00da0$%kim@samsung.com>
Message-ID: <AANLkTinQ1mP2e5DA0J_GyWn32EAckgT3b=Ar6gHzDijX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 6, 2010 at 1:43 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> Dear all,
>>
> Hi,
>
>> Now I checked the next-v310 tree and know that only LSI required codes
>> are merged.
>> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
>> samsung.git;a=shortlog;h=refs/heads/next-s5pv310
>>
>> I can't find any reason to omit the universal board file. It's posted
>> before merge window and no difference with LSI SMDK board at current
>> status.
>
> Please answer my concern..I already replied to you about this.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/022087.html
> ---
>> >> +config MACH_UNIVERSAL
>> >
>> > As I still asking, do you _really_ want to use 'UNIVERSAL' as the
>> > board(machine) name?
>>
>> Yes, it's called 'universal' and it's really universal board at here.
>> I don't confuse the engineer who develop this board.
>> Maybe your engineers saw and hear the brief description about universal
> board.
>>
> Actually, I know that. But there are S5PC100, S5PC110 universal board
> also...
> So I asked to you that you _really_ want to use 'universal' here...and I'm
> still concerning.

No comment means "Of course want to merge it". thank you for your
concerning. but I can handle it.

> ---
>
>> I try to support our board at mainline kernel but it seems to make a
>> difficult with unknown commit criteria of LSI.
>>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
