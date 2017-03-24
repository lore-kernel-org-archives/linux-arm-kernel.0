From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Mar 2017 12:13:43 +0530
Subject: [PATCH v6 10/11] drivers: perf: hisi: use poll method when no IRQ
 for MN counter overflow
In-Reply-To: <20170321171724.GC29116@leverpostej>
References: <1489127341-112908-1-git-send-email-anurup.m@huawei.com>
 <20170321171724.GC29116@leverpostej>
Message-ID: <58D4C01F.6060808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 March 2017 10:47 PM, Mark Rutland wrote:
> On Fri, Mar 10, 2017 at 01:29:01AM -0500, Anurup M wrote:
>> When no IRQ is supported in hardware, use hrtimer to poll and
>> update event counter and avoid overflow condition for MN PMU.
>> An interval of 8 seconds is used for the hrtimer.
> Please fold this into the main MN patch.
>
> The comments on the L3 hrtimer patch also apply here.

Sure. shall fix these comments. and fold to main MN patch.

Thanks,
Anurup

> Thanks,
> Mark.
