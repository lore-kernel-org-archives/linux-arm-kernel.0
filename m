From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 2 Aug 2010 15:24:13 +0900
Subject: Please remind 'WARNING: about Samsung merge window over'
In-Reply-To: <003401cb3206$d68a1fc0$839e5f40$%kim@samsung.com>
References: <003401cb3206$d68a1fc0$839e5f40$%kim@samsung.com>
Message-ID: <AANLkTimJvS0djVprEgCJ8k3_SYeaKc72NMNZNrRpqXHi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Absurd !!!

Did you mentioned that samsung merge window over before?
why it's reminder mail? it's unilateral notification at this time.

In my feelings. only include the your side (LSI) patches and don't
include others (mobile). since it's not fit your taste.
Can you explain the difference between "S5PV310 CPU support" and
"S5PV210 cpufreq support"?
Did you get any ACKs for V310 support? Why do you exclude the v210
cpufreq support even though it's acked from others?

On Mon, Aug 2, 2010 at 2:52 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Please remind following which is from discussion about Samsung merge stuff
> with Russell.
>
> ---
>
>> > So, please send the majority of patches *before* the merge window and
>> > try to avoid sending anything but fixes during the merge window itself.
>> > The merge window is for code which has _already_ been merged and has
>> > been in linux-next to be merged into Linus' tree. ?It's not for new
>> > code to be reviewed.
>>
>> Next merge window, which will probably be the last I will handle for the
>> S5P range, will have an earlier cut-off point. It was a big rush to get
>> this lot reviewed and merged.
>
> It also means that *NONE* of the stuff in your second pull request was
> in linux-next for *any* time. ?It also conflicted with my tree. ?The
> result of that is I'm expecting mainline to be dead for all ARM with:
>
> arch/arm/Kconfig:883: can't open file "arch/arm/plat-s5pc1xx/Kconfig"
>
> because of a mis-merge - and since that conflict was not picked up by
> linux-next, it could not have been previously published.
>
> For the next merge window, I will avoid reading email for the duration
> of the window - which means those who are late for the merge window will
> simply not have their patches and trees pulled. ?This means we _will_
> have time to resolve conflicts and find problems _before_ the merge
> window
>
> ---
>
> I have no more plan to merge s5p stuff for this merge window, but reviewed
> here until now.
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
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
