From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Feb 2012 10:11:14 +0000
Subject: [PATCH] msm: timer: Support sched_clock()
In-Reply-To: <20120222215533.GA31480@codeaurora.org>
References: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
 <20120222215533.GA31480@codeaurora.org>
Message-ID: <4F476242.2020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/12 21:55, David Brown wrote:
> On Tue, Feb 21, 2012 at 05:39:37PM -0800, Stephen Boyd wrote:
>> Now that sched_clock is mandatory on ARM it's simple to add
>> sched_clock support to the MSM timer code. Add it so that we get
>> more accurate sched_clock output than the jiffies based version
>> that's provided by default.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: David Brown <davidb@codeaurora.org>
> 
> Marc, are you able to pull this into your series, so they can all go
> in together?  If so:
> 
>   Acked-by: David Brown <davidb@codeaurora.org>

David, Stephen,

Russell already pulled my sched_clock() patch series, so I'm not sure it
is actually useful for me to carry it (and there is actually no
dependency between this patch and the series). Maybe putting it in the
patch system or via armsoc would be best?

Otherwise:
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
