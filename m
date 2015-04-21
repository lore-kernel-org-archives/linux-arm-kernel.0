From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Apr 2015 14:08:00 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 0/6] irq/arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <alpine.DEB.2.11.1504211445010.13914@nanos>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1504211445010.13914@nanos>
Message-ID: <55364BB0.6060108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/15 13:46, Thomas Gleixner wrote:
> On Fri, 10 Apr 2015, Daniel Thompson wrote:
> 
>> Jason/Thomas:
>>   Any chance of taking the first five of these patches via the irqchip
>>   route? The x86 patch has an ack from Ingo, printk has no explicit
>>   maintainer and I've done plenty of bisectability tests on the patchset
>>   so leaving the last patch for the next dev. cycle should be no
>>   trouble.
> 
> First of all I need an acked/reviewed from Marc or Russell,
> preferrably both of them.

I'm on it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
