From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Wed, 18 Oct 2017 21:37:40 +0800
Subject: [PATCH v5 5/6] perf: hisi: Add support for HiSilicon SoC DDRC PMU
 driver
In-Reply-To: <20171017152109.cuslnq3jsp6kx4au@lakrids.cambridge.arm.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-6-git-send-email-zhangshaokun@hisilicon.com>
 <20171017152109.cuslnq3jsp6kx4au@lakrids.cambridge.arm.com>
Message-ID: <1ce6d265-44cd-abc9-e32e-74a3afa0f162@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/10/17 23:21, Mark Rutland wrote:
> On Tue, Aug 22, 2017 at 04:07:56PM +0800, Shaokun Zhang wrote:
>> This patch adds support for DDRC PMU driver in HiSilicon SoC chip, Each
>> DDRC has own control, counter and interrupt registers and is an separate
>> PMU. For each DDRC PMU, it has 8-fixed-purpose counters which have been
>> mapped to 8-events by hardware, it assumes that counter index is equal
>> to event code (0 - 7) in DDRC PMU driver. Interrupt is supported to
>> handle counter (32-bits) overflow.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
> 
> I have the same comments for this case as for the other two PMU drivers.
> 

Sure.

Thanks,
Shaokun

> Thanks,
> Mark.
> 
> .
> 
