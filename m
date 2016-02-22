From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 22 Feb 2016 15:43:56 +0800
Subject: [PATCH v11 19/21] KVM: ARM64: Add a new feature bit for PMUv3
In-Reply-To: <20160208122957.GE620@cbox>
References: <1454656456-11640-1-git-send-email-zhaoshenglong@huawei.com>
 <1454656456-11640-20-git-send-email-zhaoshenglong@huawei.com>
 <20160208122957.GE620@cbox>
Message-ID: <56CABC3C.8000304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/2/8 20:29, Christoffer Dall wrote:
>> +bool kvm_arm_support_pmu_v3(void)
>> > +{
>> > +	/* Check if HW_PERF_EVENTS are supported by checking the number of
>> > +	 * hardware performance counters. This could ensure physical PMU and
>> > +	 * PERF_EVENT driver existing.
>> > +	 */
> nit: coding style, opening comment block should be on its own line
> 
> I don't understand the last sentence.  Do you mean: "This ensures the
> presence of a physical PMU and that CONFIG_PERF_EVENT is selected." ?
Right.

-- 
Shannon
