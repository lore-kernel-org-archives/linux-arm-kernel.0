From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Thu, 07 Jul 2011 17:31:21 +0400
Subject: [PATCH V3 1/4] ARM: smp_twd: Fix typo in 'twd_timer_rate' printing
In-Reply-To: <4E15ABA6.4000202@mvista.com>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
	<1310041396-2461-1-git-send-email-vkuzmichev@mvista.com>
	<20110707123907.GP8286@n2100.arm.linux.org.uk>
	<4E15ABA6.4000202@mvista.com>
Message-ID: <4E15B529.9070808@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/07/2011 04:50 PM, Vitaly Kuzmichev wrote:
> Hi Russell,
> 
> On 07/07/2011 04:39 PM, Russell King - ARM Linux wrote:
>> On Thu, Jul 07, 2011 at 04:23:13PM +0400, Vitaly Kuzmichev wrote:
>>> To get hundredths of MHz the rate needs to be divided by 10'000.
>>> Here is an example:
>>>  twd_timer_rate = 123456789
>>>  Before the patch:
>>>     twd_timer_rate / 1000000 = 123
>>>     (twd_timer_rate / 1000000) % 100 = 23
>>>     Result: 123.23MHz.
>>>  After being fixed:
>>>     twd_timer_rate / 1000000 = 123
>>>     (twd_timer_rate / 10000) % 100 = 45
>>>     Result: 123.45MHz.
>>>
>>> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
>>
>> -> patch system please.
> 
> For a such newbie as me it's hard to understand this comment, sorry :)
> Could you explain, please?

Ignore my question, I've learned.

Thanks,
Vitaly.
