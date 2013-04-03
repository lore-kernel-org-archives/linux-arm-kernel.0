From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 12:22:27 -0600
Subject: [PATCH] clocksource: tegra: enable arch_timer
In-Reply-To: <515C2E8F.1030802@gmail.com>
References: <1364988750-25058-1-git-send-email-josephl@nvidia.com>
 <515C2E8F.1030802@gmail.com>
Message-ID: <515C7363.4040404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 07:28 AM, Rob Herring wrote:
> On 04/03/2013 06:32 AM, Joseph Lo wrote:
>> Architected timer is the local timer for Cortex-A15. Adding the support
>> for Tegra.
>>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> 
> My patch series to add CLOCKSOURCE_OF_DECLARE support to arch timer and
> sched_clock enhancements will make this unnecessary:
> 
> http://www.spinics.net/lists/arm-kernel/msg234597.html
> 
> Testing would be appreciated.

Joseph (or Rob), what's the benefit of this change; what works with it
and/or what breaks without it?

Rob, if I did apply this change, and you also apply that series of
yours, what is the result: compile-time breakage, run-time breakage,
just some redundant code that needs to be removed again?

Thanks.
