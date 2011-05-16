From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 16 May 2011 09:28:02 +0800
Subject: [patch v4 3/3] arm: omap4: support pmu
In-Reply-To: <1305468960.2848.2.camel@jazzbox>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
	<BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
	<1305468960.2848.2.camel@jazzbox>
Message-ID: <BANLkTi==6gmitMOFuRP2DV7XB6MeippCyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/5/15 Will Deacon <will.deacon@arm.com>:
> [Adding Avik],
>
>
> On Sat, 2011-05-14 at 09:48 +0100, Ming Lei wrote:
>> Hi Rabin,
>>
>> 2011/5/14 Rabin Vincent <rabin@rab.in>:
>> > What happened to this patch? ?It is neither in mainline nor in
>> > linux-next.
>> >
>>
>> This patch depends on the two with titles:
>>
>> ? ? ? introduce cross trigger interface helpers
>> ? ? ? pmu: allow platform specific irq enable/disable handling
>>
>> and the above patches have been submitted to RMK's patch system
>> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
>> so I can't ask omap guys to merge this one into their tree now.
>
> I don't think that Avik's problem with this patch has been fully
> addressed yet:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046899.html
>
> So regardless of the state of -next, I think there's still some more
> work to do on this code before it can go upstream.

I remembered that Avik reported his issue on linaro kernel, instead of mainline.
If Avik can reproduce this issue on mainline plus pandaboard, we can help to
do it. In fact, this issue is not reproduced at all in mainline on my
pandaboard.

thanks,
-- 
Ming Lei
