From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 19 Aug 2016 11:55:49 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Don't attempt to enable
 schedutil governor as module
In-Reply-To: <20160819155140.GA12633@kozik-lap>
References: <1471612328-6467-1-git-send-email-javier@osg.samsung.com>
 <1471612328-6467-2-git-send-email-javier@osg.samsung.com>
 <9c71ddbd-deb1-1e07-7421-53bb58359bad@kernel.org>
 <7dd6278d-bdc4-14e5-6b2e-062a59cd29d4@osg.samsung.com>
 <fe0ad949-ecd1-e0fe-3d9b-04a35b9dc172@osg.samsung.com>
 <20160819155140.GA12633@kozik-lap>
Message-ID: <7d675cef-64b8-b143-6ce7-422dcfeefb6c@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 08/19/2016 11:51 AM, Krzysztof Kozlowski wrote:
> On Fri, Aug 19, 2016 at 09:52:47AM -0400, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 08/19/2016 09:46 AM, Javier Martinez Canillas wrote:
>>>
>>> On 08/19/2016 09:40 AM, Krzysztof Kozlowski wrote:
>>>> On 08/19/2016 03:12 PM, Javier Martinez Canillas wrote:
>>>>> The schedutil CPUFreq governor could be built as a module but the commit
>>>>> 58919e83c85c ("cpufreq / sched: Pass flags to cpufreq_update_util()")
>>>>> made it non-modular so attempting to enable as module leads to a warning:
>>>>>
>>>>> warning: symbol value 'm' invalid for CPU_FREQ_GOV_SCHEDUTIL
>>>>>
>>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>>
>>>>> ---
>>>>>
>>>>>  arch/arm/configs/multi_v7_defconfig | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> Looks good.
>>>>
>>>> Applied... wait, no, these are not in samsung-soc list so they miss also
>>>> from patchwork. For reference:
>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>
>>>
>>> Sigh, get_maintainers.pl suggested me an insanely large cc list so I added
>>> it manually... but I forgot linux-samsung-soc. I'll post v2.
>>>
>>
>> Damn... and now I forgot to include your collected tags in v2. I should not
>> post patches before having enough coffee, sorry about that.
>>
>> Please let me know if you don't mind or if you prefer a resend.
> 
> No problem, no need to resend.
>

I resent some minutes ago figure getting your email. So feel free to ignore v3.
 
> Applied to separate branch (not tagged yet) in case someone would like
> to base on top of it. Then please let me know, I'll add a tag.
> 
> Mentioned commit is not yet in mainline and was applied recently, so I
> remove the SHA from commit msg. The SHA might change and it's better not
> to pollute the history in that case.
> 

Ok, thanks for doing that.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
