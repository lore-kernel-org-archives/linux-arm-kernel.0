From: john.stultz@linaro.org (John Stultz)
Date: Tue, 04 Jun 2013 10:56:00 -0700
Subject: [PATCHv2 3/6] sched_clock: Make ARM's sched_clock generic for
 all architectures
In-Reply-To: <51ACF374.5040606@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-4-git-send-email-sboyd@codeaurora.org>
 <20130603071235.GO11798@tarshish> <51ACF374.5040606@codeaurora.org>
Message-ID: <51AE2A30.4010903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2013 12:50 PM, Stephen Boyd wrote:
> On 06/03/13 00:12, Baruch Siach wrote:
>> Hi Stephen,
>>
>> On Sat, Jun 01, 2013 at 11:39:40PM -0700, Stephen Boyd wrote:
>>>   {arch/arm/include/asm => include/linux}/sched_clock.h | 9 +++++++--
>> Shouldn't we just merge this header into the existing linux/sched.h?
> I don't know. John/Thomas, any thoughts? One benefit with it this way is
> that we don't have to recompile all the timer drivers if we change
> sched.h for other reasons.

Yea, I'm fine keeping it separate for now. We can merge them together if 
we see fit later.

But if anyone feels particularly strongly, let me know.

thanks
-john
