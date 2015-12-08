From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 08 Dec 2015 17:56:20 +0000
Subject: [PATCH v6 00/21] KVM: ARM64: Add guest PMU support
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <566719C4.9030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shannon,

On 08/12/15 12:47, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> This patchset adds guest PMU support for KVM on ARM64. It takes
> trap-and-emulate approach. When guest wants to monitor one event, it
> will be trapped by KVM and KVM will call perf_event API to create a perf
> event and call relevant perf_event APIs to get the count value of event.

There is still some work to do. A number of bugs, some design issues,
and in general a lot of tidying up to do. If you want this in 4.5,
you're going to have to address this quickly.

But quickly doesn't mean rushing it, and I have the feeling that this is
what you've done over the past week. Also, I've reviewed this series 3
times during that time, and I feel a bit exhausted.

So please do not send another one before the end of the week. take the
time to address all the comments, ask questions if needed, and hopefully
I can review it again next Monday.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
