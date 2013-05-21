From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Tue, 21 May 2013 12:24:32 +0000
Subject: hugetlbfs support plan for ARM
In-Reply-To: <20130521100507.GA14248@linaro.org>
References: <3E54258959B69E4282D79E01AB1F32B7044F299D@DFLE11.ent.ti.com>
 <519ACF4B.9070502@gmail.com> <20130521100507.GA14248@linaro.org>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7044F32CC@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve, Bill and Will

Thanks all for the response. So I understand this will get merged eventually to a future kernel version. If this is true, I would like to pull in the latest and give it a try on our Cortex A15 SMP ARM platform. We haven't upstream-ed this machine, but have plan to do so this year. I am on 3.8.4 kernel currently (due to dependency with RT Preempt patch) and will start using this patch and let you know the feedback.  BTW, do you see any issues with using this patch with RT Preempt kernel patch and also on A15 SMP kernel?

Thanks

Murali Karicheri
Software Design Engineer


>> -----Original Message-----
>> From: Steve Capper [mailto:steve.capper at linaro.org]
>> Sent: Tuesday, May 21, 2013 6:06 AM
>> To: bill4carson
>> Cc: Karicheri, Muralidharan; linux-arm-kernel at lists.infradead.org
>> Subject: Re: hugetlbfs support plan for ARM
>> 
>> On Tue, May 21, 2013 at 09:35:07AM +0800, bill4carson wrote:
>> > Hi, Karichri
>> >
>> > On 2013?05?21? 02:26, Karicheri, Muralidharan wrote:
>> > >Hi Bill,
>> > >
>> > >I see the patch at
>> > >http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/0
>> > >84360.html
>> > >
>> > >Is there a plan to merge this to upstream Linux kernel? I would appreciate your
>> response on this.
>> >
>> > I tried to post several round of this patch set, but haven't got more time to merge it.
>> > Steve Capper from ARM proposed both HUGEPAGE and THP in below link,
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/14
>> > 8451.html
>> >
>> > Look https://wiki.linaro.org/LEG/Engineering/Kernel/HugePages here to find what you
>> needs.
>> >
>> 
>> Hi,
>> Apologies for the delay, I am working on rebasing HugeTLB+THP for 3.10-rc1. An issue
>> with PROT_NONE has arisen, and I'm currently fixing this.
>> 
>> Cheers,
>> --
>> Steve
>> 
>> > >Thanks.
>> > >
>> > >Murali Karicheri
>> > >
>> > >/Software Design Engineer/
>> > >
>> >
>> > --
>> > ?????????,??????????
>> >
>> > --bill
