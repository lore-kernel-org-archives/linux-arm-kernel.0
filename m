From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 1 Dec 2015 09:52:15 +0800
Subject: [PATCH v4 00/21] KVM: ARM64: Add guest PMU support
In-Reply-To: <20151130183419.471ec20f@arm.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>
 <20151130183419.471ec20f@arm.com>
Message-ID: <565CFD4F.7090906@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2015/12/1 2:34, Marc Zyngier wrote:
> On Fri, 30 Oct 2015 14:21:42 +0800
> Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> 
> Hi Shannon,
> 
>> > From: Shannon Zhao <shannon.zhao@linaro.org>
>> > 
>> > This patchset adds guest PMU support for KVM on ARM64. It takes
>> > trap-and-emulate approach. When guest wants to monitor one event, it
>> > will be trapped by KVM and KVM will call perf_event API to create a perf
>> > event and call relevant perf_event APIs to get the count value of event.
> I've been through this whole series, and while this is shaping nicely,
> there is still a number of things that are a bit odd (interrupt
> injection is one, the whole CP15 reset is another).
> 
> Can you please respin this soon? I'd really like to have this in for
> 4.5...

Thanks! I will respin it soon.

-- 
Shannon
