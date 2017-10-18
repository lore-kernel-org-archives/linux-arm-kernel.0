From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Wed, 18 Oct 2017 21:35:51 +0800
Subject: [PATCH v5 4/6] perf: hisi: Add support for HiSilicon SoC HHA PMU
 driver
In-Reply-To: <20171017151826.acumob5ldoueiyg6@lakrids.cambridge.arm.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-5-git-send-email-zhangshaokun@hisilicon.com>
 <20171017151826.acumob5ldoueiyg6@lakrids.cambridge.arm.com>
Message-ID: <4b1620c9-ad8d-63ed-acf1-19ed31643178@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/10/17 23:18, Mark Rutland wrote:
> On Tue, Aug 22, 2017 at 04:07:55PM +0800, Shaokun Zhang wrote:
>> L3 cache coherence is maintained by Hydra Home Agent (HHA) in HiSilicon
>> SoC. This patch adds support for HHA PMU driver, Each HHA has own
>> control, counter and interrupt registers and is an separate PMU. For
>> each HHA PMU, it has 16-programable counters and each counter is
>> free-running. Interrupt is supported to handle counter (48-bits)
>> overflow.
> 
> My comments here are the same as for the L3C PMU driver.
> 

Sure.

Thanks,
Shaokun

> Thanks,
> Mark.
> 
> .
> 
