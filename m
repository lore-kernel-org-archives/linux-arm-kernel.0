From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 12 Feb 2016 09:43:11 -0800
Subject: [PATCH] arm64: make irq_stack_ptr more robust
In-Reply-To: <20160212174116.GI17901@arm.com>
References: <1455227590-9837-1-git-send-email-yang.shi@linaro.org>
 <56BDE260.20504@arm.com> <56BE18AB.4090902@linaro.org>
 <20160212174116.GI17901@arm.com>
Message-ID: <56BE19AF.7000605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2016 9:41 AM, Will Deacon wrote:
> On Fri, Feb 12, 2016 at 09:38:51AM -0800, Shi, Yang wrote:
>> On 2/12/2016 5:47 AM, James Morse wrote:
>>> On 11/02/16 21:53, Yang Shi wrote:
>>>> Switching between stacks is only valid if we are tracing ourselves while on the
>>>> irq_stack, so it is only valid when in current and non-preemptible context,
>>>> otherwise is is just zeroed off.
>>>
>>> Given it was picked up with CONFIG_DEBUG_PREEMPT:
>>>
>>> Fixes: 132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
>>
>> Wii add in v2.
>
> I already queued the patch with this and the whitespace fix, so no need
> for a v2.

Thanks so much.

Yang

>
> Will
>
