From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Jan 2014 15:59:27 -0800
Subject: [PATCH 1/7] ARM: perf_event: Silence sparse warning
In-Reply-To: <20140109104519.GA17838@mudshark.cambridge.arm.com>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
 <1389221984-10973-2-git-send-email-sboyd@codeaurora.org>
 <20140109104519.GA17838@mudshark.cambridge.arm.com>
Message-ID: <52CF37DF.4000309@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/14 02:45, Will Deacon wrote:
> Hi Stephen,
>
> On Wed, Jan 08, 2014 at 10:59:38PM +0000, Stephen Boyd wrote:
>> arch/arm/kernel/perf_event_cpu.c:274:25: warning: incorrect type in assignment (different modifiers)
>> arch/arm/kernel/perf_event_cpu.c:274:25: expected int ( *init_fn )( ... )
>> arch/arm/kernel/perf_event_cpu.c:274:25: got void const *const data
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
> Given that the rest of the series depends on the change to the percpu IRQ
> stuff, I think you can just send this patch to Russell's patch system with
> my ack:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>

Thanks. It's 7937/1.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
