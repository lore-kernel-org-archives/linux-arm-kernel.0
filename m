From: john.stultz@linaro.org (John Stultz)
Date: Tue, 30 Jul 2013 09:12:24 -0700
Subject: [PATCH v4 07/17] clocksource: bcm2835: Switch to
 sched_clock_register()
In-Reply-To: <51F78FCB.2020004@linaro.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-8-git-send-email-sboyd@codeaurora.org>
 <51F78FCB.2020004@linaro.org>
Message-ID: <51F7E5E8.5090000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 03:04 AM, Daniel Lezcano wrote:
> On 07/19/2013 01:21 AM, Stephen Boyd wrote:
>> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
>> the 64 bit function to allow us to remove the 32 bit registration
>> interface.
>>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
> Hi Stephen,
>
> you sent a series with tick and clocksource changes.
>
> John is recipient of part of them. I replaced him to maintain the
> clocksource drivers.
>
> Is the series you sent for clocksource drivers supposed to be taken by
> me or by Russell ?
>
> In the future if there are no dependencies, it would be preferable to
> group the clocksource drivers changes into a series and send them to me.


I believe there are some dependencies on the generic bits.

I'm planning on queing the generic parts in one branch (to send to 
thomas), queuing the drivers/clocksource bits to send to you, but was 
waiting on an Ack from Catalin.

I got busy with some other work items, so I haven't pushed these out 
yet, but I'll review things again and push them out today.

thanks
-john
