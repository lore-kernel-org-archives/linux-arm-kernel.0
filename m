From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 12 Apr 2016 14:49:40 +0200
Subject: [PATCH v6 10/10] clocksource: arm_arch_timer: Remove
 arch_timer_get_timecounter
In-Reply-To: <20160412121511.GB3039@cbox>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-11-git-send-email-julien.grall@arm.com>
 <20160412054447.GC16636@linaro.org> <20160412121511.GB3039@cbox>
Message-ID: <570CEEE4.6090503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 02:15 PM, Christoffer Dall wrote:
> Hi Daniel,
>
> On Tue, Apr 12, 2016 at 07:44:47AM +0200, Daniel Lezcano wrote:
>> On Mon, Apr 11, 2016 at 04:33:00PM +0100, Julien Grall wrote:
>>> The only call of arch_timer_get_timecounter (in KVM) has been removed.
>>>
>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>
>>> ---
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>
>>>      Changes in v4:
>>>          - Add Christoffer's acked-by
>>>
>>>      Changes in v3:
>>>          - Patch added
>>> ---
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> having acked these, do you want us to just take this a complete series
> via the kvmarm tree or do you plan on merging the patches individually?

Just take it via the kvmarm tree.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
