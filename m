From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 03 Mar 2015 11:56:21 +0000
Subject: [PATCH] clocksource: arm_arch_timer: Rename arch_timer_probed
 to reflect behaviour
In-Reply-To: <1634669.Cj7rnHN4gq@avalon>
References: <1421488012-5098-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <54C56582.6080809@linaro.org> <1634669.Cj7rnHN4gq@avalon>
Message-ID: <54F5A165.4010408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/03/15 13:00, Laurent Pinchart wrote:
> Hello,
>
> On Sunday 25 January 2015 22:52:02 Daniel Lezcano wrote:
>> On 01/17/2015 10:46 AM, Laurent Pinchart wrote:
>>> The arch_timer_probed function returns whether the given time doesn't
>>> need to be probed. This can be the case when the timer has been probed
>>> already, but also when it has no corresponding enabled node in DT.
>>>
>>> Rename the function to arch_timer_need_probe and invert its return value
>>> to better reflect the function's purpose and behaviour.
>>>
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>
>> I would like to have an ack from Sudeep or Mark (Cc'ed) before taking
>> this patch.
>
> Sudeep, Mark, ping ?
>

Looks fine to me. I just wanted to test on KVM which I had broke once
previously though this change is pretty straight forward and simple.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
