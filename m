From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 04:03:03 +0900
Subject: ASoC: samsung: MACH_SMDKC100
In-Reply-To: <1405673749.2155.5.camel@x220>
References: <1404288063.12021.13.camel@x220> <1405673749.2155.5.camel@x220>
Message-ID: <53C96F67.7010108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/14 17:55, Paul Bolle wrote:
> Kukjin,
>
Hi Paul,

> On Wed, 2014-07-02 at 10:01 +0200, Paul Bolle wrote:
>> Your commit 52ad6582ceb2 ("ARM: S5PC100: no more support S5PC100 SoC"
>> landed in next-20140702. It removed the Kconfig symbol MACH_SMDKC100
>> (and a lot of other stuff).
>>
>> Is the trivial patch to also remove the last two references to
>> MACH_SMDKC100 from sound/soc/samsung/Kconfig/ queued somewhere? I don't
>> think it was part of the series that included the above commit.
>
> Have you had time to look at this? Those last two references to
> MACH_SMDKC100 can still be seen in next-20140718.
>
Yeah you're right. The MACH_SMDKC100 is no more required...

I submitted its fixup to Mark and I think he will take it for v3.17.

Thanks,
Kukjin
