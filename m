From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 10 Jan 2014 08:31:28 -0800
Subject: =?utf-8?B?562U5aSNOg==?= [PATCH 1/3] ARM: hisi: rename hi3xxx
 to hisi
In-Reply-To: <87a9f7csja.fsf@linaro.org> (Kevin Hilman's message of "Tue, 07
 Jan 2014 14:54:01 -0800")
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
 <CAOesGMjaJVWoMWgywkHfeD+0TMw3pze40CAvTcuC7+NavMq22w@mail.gmail.com>
 <87sitnh1bz.fsf@linaro.org>
 <8B36690B4C1B584EAD95DD4902A4FF37095E90C3@SZXEMA511-MBS.china.huawei.com>
 <87a9f7csja.fsf@linaro.org>
Message-ID: <878uunbxy7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@linaro.org> writes:

> "xuwei (O)" <xuwei5@hisilicon.com> writes:
>
>> Hi Olof and Kevin,
>
> Hello.
>
> Please don't top post (c.f. http://kernelnewbies.org/mailinglistguidelines)
>
>> Please calm down.
>>
>> Both of us have a hard time to enable hi3xxx in kernel v3.14.
>> Let me explain it.
>
> I'm not sure an explanation is required, I understand the history here
> pretty well.  I've been involved in reviewing multiple versions of this
> series.  Also, I did lots of manual fixups for this series[1] which we
> don't normally do.
>
>> We have a new serial of SoCs for server market and they will named with hipxx.
>> And hi3xxx SoCs are for the mobile and STB market.
>> Now we hope to enable the hipxx SoCs in the kernel.
>> To make the "mach" directory simple, we hope hipxx SoCs could share the same directory with hi3xxx.
>> But according current situation, maybe we should add a new "mach" for the hipxx firstly.
>> Do you think is it OK?
>
> Yes, that's all fine and good.  Nobody has objected to the rename
> itself.  In fact, we think it's better naming.  Earlier reviews in the
> series pointed out that the naming was messy and difficult to
> understand.
>
> What we've objected to was the timing and organization.  I had just
> merged the v12 series (after having to do a bunch of manual fixes) which
> was a major pain.  As soon as that was merged, the rename series was
> sent.
>
> The primary problem we have is that the rename is pointless churn.  
>
> Put simply, you should have done the rename in the original series much
> earlier, not as an add-on series.
>
>> And for hi3xxx SoCs, could you please keep it in the next?
>
> I've just returned from 2 weeks off over the end of year holidays, and
> I'm looking into it now, and not sure yet if it will make it for v3.14.

The original hi3xxx series *plus* the rename is now merged into next/soc
for v3.14.

Kevin
