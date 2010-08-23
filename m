From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 23 Aug 2010 18:22:02 +0800
Subject: [PATCH 1/5] mfd: add codec resource into 88pm860x driver
In-Reply-To: <20100820214235.GG3650@sortiz-mobl>
References: <AANLkTi=NVRGys_Mv8u-2Ca6w2r1F2DCvKdquqsquwbpH@mail.gmail.com>
	<20100813135858.GA6449@rakim.wolfsonmicro.main>
	<20100820214235.GG3650@sortiz-mobl>
Message-ID: <AANLkTinRiZi7Sf+UXKLNXU3CE+j6AKo7M4scbj04rj79@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 21, 2010 at 5:42 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> On Fri, Aug 13, 2010 at 02:58:58PM +0100, Mark Brown wrote:
>> On Fri, Aug 13, 2010 at 09:55:19PM +0800, Haojian Zhuang wrote:
>> > From 7f48ab298f0017ff8b86dbc11f8de21505965ce7 Mon Sep 17 00:00:00 2001
>> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > Date: Thu, 12 Aug 2010 11:59:33 +0800
>> > Subject: [PATCH 1/5] mfd: add codec resource into 88pm860x driver
>> >
>> > Add codec IRQ resources that are used in 88pm860x codec driver.
>>
>> CCing in Samuel since this ought to have his ack.
> The patch looks good. I'll ack it once Mark's comment gets integrated.
> As for how it should hit upstream, I'm fine taking it unless Haojian prefers
> to see the whole patchset going through Liam's tree.
>
> Cheers,
> Samuel.
>
>> It may as well be
>> merged via the MFD tree since there's no build time dependency, I guess.
>> I do have one comment...
>>

Actually I'm OK whether this patch is merged into mfd tree or ASoC tree.

And I refreshed this patch by changing hardcoding to ARRAY_SIZE().
I'll paste it in another mail thread. Please help to review it again.

Thanks
Haojian
