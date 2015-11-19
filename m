From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 19 Nov 2015 15:18:47 -0300
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <CAGOxZ50b3cGXQSFL1uXt7O=CyBOaE=7WRQ-tSz8NUmWzBdhxoQ@mail.gmail.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de>
 <56272C1C.8040007@samsung.com> <562765F3.9010306@osg.samsung.com>
 <CAGOxZ52-ia8uhgGg5CiU9TSYkfAsRD52zvLqq++Y-mr4uaFOpg@mail.gmail.com>
 <5627A75E.60509@osg.samsung.com>
 <CAGOxZ537QuzBP4tcG9qh-+iXK-Y=WwZGiJ1-cwtLqwRf0a+wVA@mail.gmail.com>
 <56282B2D.6000708@samsung.com>
 <CAGOxZ50b3cGXQSFL1uXt7O=CyBOaE=7WRQ-tSz8NUmWzBdhxoQ@mail.gmail.com>
Message-ID: <CABxcv=nr3ueCouu5R-z7uVbYx4nkOgqbY0s8Vh8hPBKpLj1FTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On Thu, Nov 19, 2015 at 3:06 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:

[snip]

>>
>> Javier, Alim, Ulf,
>>
>> I am not grabbing any more patches for v4.4 because I doubt that they
>> could be merged to arm-soc for this cycle. My last pull requests for
>> v4.4 is still pending...
>>
>> This means that I plan to pick up these series for v4.5, after closing
>> v4.4 merge window (unless Kukjin picks it also). Because of that, we
>> have plenty of time, so my idea is:
>> 1. Wait for some comments from Ulf on Javier's fix.
>> 2. If the fix goes into v4.4, then problem solved.
>> 3. If not and it get acked, then it can go with this set.
>> 4. If not and it get applied by Ulf for v4.5, then a tag from him would
>> be a nice way to solve dependency.
>>
>> Either way we don't have to hurry, I think.
>>
>
> Is It the right time to get this series in?

The patch that the series had as a dependency made it to v4.4-rc1 as
commit 1c6e58d83615 ("mmc: pwrseq: Use highest priority for eMMC
restart handler") so it should be safe now to pick this series for
v4.5.

> Thanks!!
>

Best regards,
Javier
