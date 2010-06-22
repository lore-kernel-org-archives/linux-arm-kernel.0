From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Jun 2010 15:30:51 +0800
Subject: Samsung SoCs naming rules
In-Reply-To: <011201cb11c8$8236c530$86a44f90$%kim@samsung.com>
References: <AANLkTiljyiQohHVJxUsn7Q6_IwTZk2AdNlLRxgGmxNpQ@mail.gmail.com>
	<AANLkTilnjN1dBWPKCuDt_bg8-5GEuSCrOh7vhqGf-VQU@mail.gmail.com>
	<011201cb11c8$8236c530$86a44f90$%kim@samsung.com>
Message-ID: <AANLkTinRpWoVSUvDhNsMSF3-zdh-tyCy_xMBwdOV1iLz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 1:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Eric Miao wrote:
>>
>> On Mon, Jun 21, 2010 at 6:00 PM, Kyungmin Park <kmpark@infradead.org>
> wrote:
>> > Dear all,
>> >
>> > Now Samsung SoCs doesn't have any special rules include chip name.
>> >
>> > Historically s5pc100 is successor form s3c6410 and this chip from
>> > s3c2410 series.
>> > on the other hand, s5pc110 (cortex a8) and s5pc64xx (armv6) is
>> > different from previous chips.
>>
>> Don't be shy, Samsung is not the only vendor messes the naming of their
>> SoCs. Marvell might have done a better job on this :-)
>>
>> >
>> > So it's not good idea grouping with the prefix. e.g., s5p series. and
>> > the reason to create the samsung.
>> >
>>
>> My guess is your s5p will focus more on Cortex-A8 (or A9 possibly),
>> even with subsequent processors. And only s5pc100 is an exception,
>> that's fine, you can still put s5pc100 into mach-s3c6410, and people
>> will know it's actually closer to s3c6410. And other SoCs will share the
>> common s5p prefix.
>
> Hi Eric,
>
> Actually, S5P does not focus on only Cortex-A8 or -A9.
> The S5P6440 and S5P6442 which have ARM11 core are S5P series in Samsung
> SoCs, too.

Sometimes it's not possible to have a perfect and consistent naming.
So if s5p644x is more like s3c64xx, actually it's OK to merge them
unless there are fundamental changes.

>
> Besides, other S5P SoC which has ARM11 core will be produced.
>
> And S5PC100 is Cortex-A8 SoC, the architecture is different from S3C6410.

And sometimes it's not a problem even with different ARM cores, the
core does actually have a good abstraction already. The major differences
are the components around that core, at the SoC level.

I'm still a bit puzzled since the question seems to be too generic. Could you
please give some examples of the naming issues you have, specifically?
